//
//  BluetoothController+Serial.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 6/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

/*
 This file is extension of Serial Delegate
*/

import Foundation
import CoreBluetooth
import MKKit
import MKUtilityKit

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
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func serialDidReceiveString(_ message: String) {
    
        textRecieved += message
        
        let matched = matches(for: "(-[^-]+-)", in: textRecieved)
        
        for match: String in matched {
            let strToProcess = match.replacingOccurrences(of: "-", with: "")
            
            if bluetoothDebug {
                MKULog.shared.debug("[BLUETOOTH][SERIAL] Processing: \(strToProcess)")
            }
        
            let processed = processString(str: strToProcess)
            
            switch processed.0 {
            case .noDataType:
                serialDelegate?.hasNewOutput("No Data Type: \(processed.1)")
                
            case .info:
                serialDelegate?.hasNewOutput(processed.1)
                
            case .compass:
                let angle = processed.1
                
                guard let ang = Double(angle) else {
                    break
                }
                
                compassDelegate?.hasNewHeading(ang)
                
            case .tsop:
                let angle = processed.1
                
                guard let ang = Double(angle) else {
                    break
                }
                
//                compassDelegate?.hasNewHeading(ang)
                
                tsopDelegate?.hasNewDirection(ang)
            case .light:
                let boolArr = Array(processed.1.characters)
                
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
                
            case .robotPoisition:
                let positionString = processed.1
                
                guard let positionInt = Int(positionString) else {
                    return
                }
                
                guard let position = RobotPosition(rawValue: positionInt) else {
                    return
                }
                
                robotPositionDelegate?.updatePosition(position: position)
                
            default:
                MKULog.shared.debug("[BLUETOOTH][Controller] Recieved: \(processed)")
            }
        }
        
        let comps = textRecieved.components(separatedBy: "-")
        
        if comps.count > 1 {
            if comps[comps.count - 2] == "" && comps.last == "" {
                textRecieved = "-"
            } else if comps.last != "" {
                textRecieved = "-" + comps.last!
            } else {
                textRecieved = ""
            }
        }
    }
    
    func processString(str: String) -> (BluetoothDataType, String) {
        let comps = str.components(separatedBy: ";")
        
        if comps.count == 2 {
            guard let unwrappedString = Int(comps.first!) else {
                return (BluetoothDataType.noDataType, comps[1])
            }
            
            guard let dataType = BluetoothDataType(rawValue: unwrappedString) else {
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
        tsopDelegate?.hasNewDirection(0)
        compassDelegate?.hasNewHeading(0)
        lightSensDelegate?.updatedCurrentLightSensors([])
        connect()
    }
}
