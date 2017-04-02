//
//  AppDelegate.swift
//  LJ STAND macOS
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa
import MKKit
import MKUtilityKit
import CoreBluetooth

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var lastMessage: String?
    var alert: NSAlert?

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		BluetoothController.shared.bluetoothDebug = false
        BluetoothController.shared.overrideConnect = true
        BluetoothController.shared.messageDelegate = self
        
        MKULog.shared.logDetails()
        BluetoothController.shared.overrideConnect = false
	}
}

extension AppDelegate: BluetoothMessageDelegate {
    func showError(_ message: String) {
        if message != lastMessage {
            lastMessage = message
            commonAlert(message)
        }
        
        MKULog.shared.error(message)
    }
    
    func showInformation(_ message: String) {
        if message != lastMessage {
            lastMessage = message
        }
        
        MKULog.shared.info(message)
    }
    
    func dismissNotifications() {
        //TODO: Find a way to dismiss NSAlert
    }
    
    func foundDevices(_ peripherals: [CBPeripheral]) {
        if peripherals.count == 1 {
            BluetoothController.shared.connectTo(peripherals.first!)
        }
    }
    
    func commonAlert(_ message: String) {
            
        alert = NSAlert()
        alert?.alertStyle = NSAlertStyle.warning
        alert?.messageText = message
        alert?.addButton(withTitle: "Close")
        alert?.delegate = self
        alert?.runModal()
    }
}

extension AppDelegate: NSAlertDelegate {
    func alertShowHelp(_ alert: NSAlert) -> Bool {
        print([alert])
        return true
    }
}
