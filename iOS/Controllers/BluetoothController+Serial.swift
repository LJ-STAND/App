//
//  BluetoothController+Serial.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 6/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

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
        
        guard self.overrideConnect == false else {
            return
        }
    
        textRecieved += message
        
        let matched = matches(for: "(-[^-]+-)", in: textRecieved)
        
        for match: String in matched {
            let strToProcess = match.replacingOccurrences(of: "-", with: "")
            
            if bluetoothDebug {
                MKUAsync.background {
                    MKULog.shared.debug("[BLUETOOTH][SERIAL] Processing: \(strToProcess)")
                }
            }
        
            let processed = processString(str: strToProcess)
            
            let robot = processed.0
            
            if bluetoothDebug {
                MKUAsync.background {
                    MKULog.shared.debug(processed)
                }
            }
            
            switch processed.1 {
            case .noDataType:
                serialDelegate?.hasNewOutput("No Data Type: \(processed.2)")
                
            case .info:
                serialDelegate?.hasNewOutput(processed.2)
                
            case .compass:
                let angle = processed.2
                
                guard let ang = Double(angle) else {
                    break
                }
                
                compassDelegate?.hasNewHeading(ang, robot: robot)
                
            case .tsop:
                let angle = processed.2
                
                guard let ang = Double(angle) else {
                    break
                }
                
                tsopDelegate?.hasNewDirection(ang, robot: robot)
            case .light:
                let boolArr = Array(processed.2.characters)
                
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
                let positionString = processed.2
                let items = positionString.components(separatedBy: ",")
                
                guard let angle = Double(items[0]) else {
                    break
                }
                
                guard let size = Double(items[1]) else {
                    break
                }
                
                robotPositionDelegate?.updatePosition(angle: angle, size: size, robot: RobotNumber.noRobot)
                
            case .orbitAngle:
                let angle = processed.2
                
                guard let ang = Double(angle) else {
                    break
                }
                
                tsopDelegate?.hasNewOrbitAngle(ang, robot: robot)
                
            case .pixy:
                let rawData = processed.2
                let rawArray = rawData.components(separatedBy: ",")
                
                var arrayData: [Double] = []
                
                for item in rawArray {
                    let doubleVal = Double(item)
                    arrayData.append(doubleVal!)
                }
                
                pixyDelegate?.updatedGoalInformation(x: arrayData[0], y: arrayData[1], width: arrayData[2], height: arrayData[3])
                
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
    
    func processString(str: String) -> (RobotNumber, BluetoothDataType, String) {
        let comps = str.components(separatedBy: ";")
        
        var robotNumber = RobotNumber.noRobot
        var dataType = BluetoothDataType.noDataType
        var message = ""
        
        var rawRobotNumber: String?
        var rawDataType: String?
        var rawMessage: String?
        
        if comps.count == 3 {
            rawRobotNumber = comps[0]
            rawDataType = comps[1]
            rawMessage = comps[2]
            
            robotNumber = processRobotNumber(rawRobotNumber: rawRobotNumber ?? "0")
        } else if comps.count == 2 {
            rawDataType = comps[0]
            rawMessage = comps[1]
        }
        
        message = rawMessage ?? ""
        dataType = processDataType(rawDataType: rawDataType ?? "0")
        
        
        
        return (robotNumber, dataType, message)
    }
    
    func processDataType(rawDataType: String) -> BluetoothDataType {
        guard let dataInt = Int(rawDataType) else {
            return .noDataType
        }
        
        guard let dataType = BluetoothDataType(rawValue: dataInt) else {
            return .noDataType
        }
        
        return dataType
    }
    
    func processRobotNumber(rawRobotNumber: String) -> RobotNumber {
        guard let robotNumber = Int(rawRobotNumber) else {
            return .noRobot
        }
        
        guard let robotType = RobotNumber(rawValue: robotNumber) else {
            return .noRobot
        }
        
        return robotType
    }
    
    func serialDidChangeState() {
        self.connectCount = 0
        connect()
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        self.connected = false
        self.connectCount = 0
        serialDelegate?.hasNewOutput("Disconnected from \(peripheral.name!)")
        tsopDelegate?.hasNewDirection(0, robot: .noRobot)
        compassDelegate?.hasNewHeading(0, robot: .noRobot)
        lightSensDelegate?.updatedCurrentLightSensors([])
        connect()
    }
}
