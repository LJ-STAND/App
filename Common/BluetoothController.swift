//
//  BluetoothController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import Foundation
import CoreBluetooth
import MKKit
import MKUtilityKit

enum BluetoothDataType: Int {
    case noDataType
    case info
    case tsop
    case light
    case compass
    case rawData
    case linePosition
    case robotPoisition
}

protocol BluetoothMessageDelegate {
    func showInformation(_ message: String)
    func showError(_ message: String)
    func foundDevices(_ peripherals: [CBPeripheral])
    func dismissNotifications()
}

protocol BluetoothControllerSerialDelegate {
    func hasNewOutput(_ serial: String)
}

protocol BluetoothControllerTSOPDelegate {
    func hasNewActiveTSOP(_ tsopNum: Int)
}

protocol BluetoothControllerCompassDelegate {
    func hasNewHeading(_ angle: Double)
}

protocol BluetoothControllerLightSensorDelegate {
    func updatedCurrentLightSensors(_ sensors: [Int])
}

class BluetoothController {
    static let shared = BluetoothController()
    
    var serialDelegate: BluetoothControllerSerialDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    
    var tsopDelegate: BluetoothControllerTSOPDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    var compassDelegate: BluetoothControllerCompassDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    
    var lightSensDelegate: BluetoothControllerLightSensorDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    
    var messageDelegate: BluetoothMessageDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    
    
    var peripherals: [CBPeripheral] = []
    var rssis: [Float] = []
    var selectedPeripheral: CBPeripheral?
    var connectCount = 0
    var overrideConnect = false
    
    var connected: Bool = false
    var bluetoothDebug: Bool = false
    
    init() {
        serial = BluetoothSerial(delegate: self)
        serial.writeType = .withoutResponse
    }
    
    func connectTo(_ peripheral: CBPeripheral) {
        self.selectedPeripheral = peripheral
        serial.connectToPeripheral(peripheral)
    }
    
    func connect() {
        if !overrideConnect && connectCount < 3 {
            MKUAsync.main {
                self.messageDelegate?.showInformation("Scanning for Bluetooth Devices...")
            }.background {_ in 
                serial.startScan()
                sleep(2)
            }.main {
                serial.stopScan()
                
                if self.peripherals.count > 0 {
                    
                    let lastDevice = UserDefaults.standard.string(forKey: "lastConnected")
                    
                    var last: CBPeripheral?
                    for device in self.peripherals {
                        if device.name == lastDevice {
                            last = device
                        }
                    }
                    
                    if last != nil {
                        self.selectedPeripheral = last!
                        serial.connectToPeripheral(last!)
                    } else {
                        self.messageDelegate?.foundDevices(self.peripherals)
                    }
                } else {
                    var count = self.connectCount
                    count = count + 1
                    self.connectCount = count
                    self.connect()
                }
            }
        } else {
            messageDelegate?.dismissNotifications()
        }
    }
}


extension BluetoothController: BluetoothSerialDelegate {
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        for exisiting in peripherals {
            if exisiting.identifier == peripheral.identifier { return }
        }
        
        let theRSSI = RSSI?.floatValue ?? 0.0
        peripherals.append(peripheral)
        rssis.append(theRSSI)
    }
    
    
    func serialDidConnect(_ peripheral: CBPeripheral) {
        messageDelegate?.dismissNotifications()
        messageDelegate?.showInformation("[BLUETOOTH] [CONTROLLER] Conntected to \(peripheral.name!)")
        MKULog.shared.info("[BLUETOOTH] [CONTROLLER] Peripheral Details: \(peripheral.description)")
        
        let text = "Connected to \(peripheral.name ?? "")"
        serialDelegate?.hasNewOutput(text)
        self.connected = true
        
        MKUDefaults().defaults.set(peripheral.name!, forKey: "lastConnected")
    }
    
    func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?) {
        messageDelegate?.showError("Connection Failed. \(String(describing: error?.localizedDescription))")
        
        sleep(1)
        self.connectCount = 0
        connect()
    }
    
    func serialDidReceiveString(_ message: String) {
        if bluetoothDebug {
            MKULog.shared.debug("[BLUETOOTH] [CONTROLLER] String before processing: \(message)")
        }
        
        let processed = processString(str: message)
        
        switch processed.0 {
        case .noDataType:
            serialDelegate?.hasNewOutput("No Data Type: \(processed.1)")
            
        case .info:
            serialDelegate?.hasNewOutput(processed.1)
            
        case .compass:
            let angle = processed.1
            
            guard let ang = Double(angle) else {
                let mess = "[Compass] Angle was unable to be converted into Double: \(angle)"
                serialDelegate?.hasNewOutput(mess)
                messageDelegate?.showInformation(mess)
                return
            }
            
            compassDelegate?.hasNewHeading(ang)
            
        default:
            MKULog.shared.debug("[BLUETOOTH][Controller] Recieved: \(processed)")
        }
    }
    
    func processString(str: String) -> (BluetoothDataType, String) {
        let comps = str.components(separatedBy: ";")
        
        if comps.count == 2 {
            guard let dataType = BluetoothDataType(rawValue: (Int(comps.first!))!) else {
                return (BluetoothDataType.noDataType, comps[1])
            }
            
            let message = comps[1]
            
            return (dataType, message)
        }
        
        return (.noDataType, "")
    }
 
    func serialDidChangeState() {
        self.connectCount = 0
        connect()
    }
 
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        self.connected = false
        self.connectCount = 0
        serialDelegate?.hasNewOutput("Disconnected from \(peripheral.name!)")
        tsopDelegate?.hasNewActiveTSOP(-1)
        compassDelegate?.hasNewHeading(0)
        lightSensDelegate?.updatedCurrentLightSensors([])
        connect()
    }
}
