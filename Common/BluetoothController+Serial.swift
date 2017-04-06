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
                return
            }
            
            compassDelegate?.hasNewHeading(ang)
            
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
            
        case .settings:
            //TODO:
            break
            
            
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
