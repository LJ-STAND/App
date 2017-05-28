//
//  AppDelegate+Bluetooth.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 24/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
import MKUIKit
import MKUtilityKit
import CoreBluetooth

extension AppDelegate: BluetoothMessageDelegate {
    func showInformation(_ message: String) {
        MKUIToast.shared.showNotification(text: message, alignment: .center, color: .flatBlue, identifier: nil, callback: {})
        MKULog.shared.info(message)
    }
    
    func showError(_ message: String) {
        MKUIToast.shared.showNotification(text: message, alignment: .center, color: .flatRed, identifier: nil, callback: {})
        MKULog.shared.error(message)
    }
    
    func foundDevices(_ peripherals: [CBPeripheral]) {
        let alert = UIAlertController(title: "Connect to Device", message: nil, preferredStyle: .alert)
        
        for item in peripherals {
            alert.addAction(UIAlertAction(title: item.name, style: .default, handler: { (action) in
                BluetoothController.shared.connectTo(item)
            }))
        }
        
        window?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    func dismissNotifications() {
        MKUIToast.shared.dismissAllNotifications(animated: false)
    }
}

