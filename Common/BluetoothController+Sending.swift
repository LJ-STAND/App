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
        let dataType = BluetoothDataType.settings
        let message = "9"
        let msgToSend = "\(dataType.rawValue);\(message)"
        serial.sendMessageToDevice(msgToSend)
    }
    
    func sendSettings(compass: Bool, tsop: Bool, light: Bool) {
        let array = [compass, tsop, light]
        
        var binaryString = ""
        
        for item in array {
            binaryString += String(item.hashValue)
        }
        
        let type = BluetoothDataType.settings.rawValue
        
        let finalString = "\(type);\(binaryString)"
        
        serial.sendMessageToDevice(finalString)
    }
}
