//
//  BluetoothController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import Foundation
import CoreBluetooth
import MKUIKit
import MKKit
import MKUtilityKit

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
    
    var peripherals: [CBPeripheral] = []
    var rssis: [Float] = []
    var selectedPeripheral: CBPeripheral?
    var connectCount = 0
    
    var connected: Bool = false
    
    init() {
        serial = BluetoothSerial(delegate: self)
        serial.writeType = .withoutResponse
    }
    
    func connect() {
        if !UIDevice.current.isSimulator && connectCount < 3 {
            MKUAsync.main {
                MKUIToast.shared.showNotification(text: "Scanning for Bluetooth Devices...", alignment: .center, color: UIColor.flatBlue, identifier: nil, callback: {
                })
            }.background {
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
                        let alert = UIAlertController(title: "Connect to Device", message: nil, preferredStyle: .alert)
                        
                        for item in self.peripherals {
                            alert.addAction(UIAlertAction(title: item.name, style: .default, handler: { (action) in
                                self.selectedPeripheral = item
                                serial.connectToPeripheral(item)
                            }))
                        }
                        
                        self.getRootView().present(alert, animated: true, completion: nil)
                        
                    }
                } else {
                    var count = self.connectCount
                    count = count + 1
                    self.connectCount = count
                    self.connect()
                }
            }
        } else {
            MKUIToast.shared.dismissAllNotifications(animated: true)
        }
    }
    
    fileprivate func getRootView() -> UIViewController {
        return ((UIApplication.shared.delegate as! AppDelegate).windowManager?.rootViewController)!!
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
        MKUIToast.shared.dismissAllNotifications(animated: false)
        MKUIToast.shared.showNotification(text: "Connected to \(peripheral.name ?? "")", alignment: .center, color: UIColor.flatGreen, identifier: nil) {}
        
        let text = "Connected to \(peripheral.name ?? "")"
        serialDelegate?.hasNewOutput(text)
        self.connected = true
        
        UserDefaults.standard.set(peripheral.name!, forKey: "lastConnected")
    }
    
    func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?) {
        MKUIToast.shared.showNotification(text: "Connection Failed. \(String(describing: error?.localizedDescription))", alignment: .center, color: UIColor.flatRed, identifier: nil) {}
        sleep(1)
        self.connectCount = 0
        connect()
    }
    
    func serialDidReceiveString(_ message: String) {
        let comps = message.components(separatedBy: ";")
        
        let string = "1"
        let tsop = "2"
        let light = "3"
        let compass = "4"
        
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
            } else if comps[0] == string {
                serialDelegate?.hasNewOutput(comps[1].trimmingCharacters(in: CharacterSet.init(charactersIn: "\r\n")))
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
