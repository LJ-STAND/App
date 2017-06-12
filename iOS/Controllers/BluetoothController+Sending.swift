//
//  BluetoothController+Sending.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 6/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation
import MKUtilityKit

extension BluetoothController: BluetoothControllerSendDelegate {
    
    func requestSettings() {
        let msgToSend = generateMessage(type: .settings, message: "9")
        serial.sendMessageToDevice(msgToSend)
    }
    
    func sendSettings(compass: Bool, tsop: Bool, light: Bool) {
        let array = [compass, tsop, light]
        
        var binaryString = ""
        
        for item in array {
            binaryString += String(item.hashValue)
        }
        
        let type = BluetoothDataType.settings
        
        let finalString = generateMessage(type: type, message: binaryString)
        
        serial.sendMessageToDevice(finalString)
    }
    
    fileprivate func generateMessage(type: BluetoothDataType, message: String) -> String {
        return "\(type);\(message)"
    }
}
