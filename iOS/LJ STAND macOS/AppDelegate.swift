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

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		BluetoothController.shared.messageDelegate = self
        BluetoothController.shared.compassDelegate = self
        BluetoothController.shared.serialDelegate = self
        BluetoothController.shared.tsopDelegate = self
        MKULog.shared.logDetails()
	}
}

extension AppDelegate: BluetoothMessageDelegate {
    func showError(_ message: String) {
        commonAlert(message)
    }
    
    func showInformation(_ message: String) {
        commonAlert(message)
    }
    
    func dismissNotifications() {
        //TODO:
    }
    
    func foundDevices(_ peripherals: [CBPeripheral]) {
        if peripherals.count == 1 {
            BluetoothController.shared.connectTo(peripheral: peripherals.first!)
        }
    }
    
    func commonAlert(_ message: String) {
        let alert = NSAlert()
        
        alert.alertStyle = NSAlertStyle.warning
        alert.messageText = message
        alert.addButton(withTitle: "Close")
        alert.delegate = self
        alert.runModal()
    }
}

extension AppDelegate: BluetoothControllerTSOPDelegate, BluetoothControllerSerialDelegate,BluetoothControllerCompassDelegate {
    func hasNewHeading(_ angle: Double) {
        commonAlert("Angle: \(angle)")
    }
    
    func hasNewOutput(_ serial: String) {
        commonAlert(serial)
    }
    
    func hasNewActiveTSOP(_ tsopNum: Int) {
        commonAlert("TSOP: \(tsopNum)")
    }
}

extension AppDelegate: NSAlertDelegate {
    func alertShowHelp(_ alert: NSAlert) -> Bool {
        print([alert])
        return true
    }
}
