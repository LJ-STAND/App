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
    
    var serialDelegate: BluetoothControllerSerialDelegate?
    var tsopDelegate: BluetoothControllerTSOPDelegate?
    var compassDelegate: BluetoothControllerCompassDelegate?
    var lightSensDelegate: BluetoothControllerLightSensorDelegate?
    var messageDelegate: BluetoothMessageDelegate?
    
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
    
    func connectTo(peripheral: CBPeripheral) {
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
        messageDelegate?.showInformation("Connected to \(peripheral.name ?? "")")
        
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
        let comps = message.components(separatedBy: ";")
        
        let noDataType = "0" // Shouldn't recieve
        let serial = "1" //Info is Serial
        let tsop = "2"
        let light = "3"
        let compass = "4"
        let raw = "5" // Shouldn't recieve
        
        if bluetoothDebug {
            MKULog.shared.debug("[BLUETOOTH] [CONTROLLER] - \(comps)")
        }
        
        if comps.count > 1 {
            if comps[0] == tsop {
                let tsopstr = comps[1].trimmingCharacters(in: CharacterSet.init(charactersIn: "\r\n"))
                
                guard let active = Int(tsopstr) else {
                    return
                }
                
                tsopDelegate?.hasNewActiveTSOP(active)
                
            } else if comps[0] == light {
                let string = comps[1].trimmingCharacters(in: CharacterSet.init(charactersIn: "\r\n"))
                let boolArr = Array(string.characters)
                
                if boolArr.count == 12 {
                    var sensorStatus: [Int] = []
                    
                    for i in 0...11 {
                        let item = boolArr[i]
                        let intValue = Int(String(item))
                        
                        if intValue == 1 {
                            sensorStatus.append(1)
                            sensorStatus.append(0)
                        } else if intValue == 2 {
                            sensorStatus.append(0)
                            sensorStatus.append(1)
                        } else if intValue == 3 {
                            sensorStatus.append(1)
                            sensorStatus.append(1)
                        } else {
                            sensorStatus.append(0)
                            sensorStatus.append(0)
                        }
                        
                        var sensorNumbers: [Int] = []
                        
                        if sensorStatus.count == 24 {
                            for i in 0...23 {
                                let value = sensorStatus[i]
                                
                                if value == 1 {
                                    sensorNumbers.append(i)
                                }
                            }
                            
                            lightSensDelegate?.updatedCurrentLightSensors(sensorNumbers)
                        }
                    }
                }
            } else if comps[0] == compass {
                let ang = comps[1].trimmingCharacters(in: CharacterSet.init(charactersIn: "\r\n"))
                
                guard let angle = Double(ang) else {
                    return
                }
                
                compassDelegate?.hasNewHeading(angle)
            } else if comps[0] == serial {
                //Info is serial
                serialDelegate?.hasNewOutput(comps[1].trimmingCharacters(in: CharacterSet.init(charactersIn: "\r\n")))
            } else if comps[0] == noDataType || comps[0] == raw {
                MKULog.shared.error("[BLUETOOTH] [CONTROLLER] Message Didn't contain a data type.")
            }
        } else {
            serialDelegate?.hasNewOutput(message)
        }
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
