//
//  InitialViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa
import MKKit
import MKUtilityKit

class InitialViewController: NSViewController {
    var lightSensorWindowController: NSWindowController?
    var compassWindowController: NSWindowController?
    var tsopWindowController: NSWindowController?
    var serialWindowController: NSWindowController?
    
	@IBAction func serialAction(_ sender: Any) {
        if serialWindowController == nil {
            let vc = getViewControllerFromID("serial")
            vc.title = "Serial"
            
            serialWindowController = NSWindowController(window: NSWindow(contentViewController: vc))
            serialWindowController?.showWindow(self)
        } else {
            serialWindowController?.showWindow(self)
        }
	}
    
	@IBAction func lightSensorsAction(_ sender: Any) {
        if lightSensorWindowController == nil {
            let vc = getViewControllerFromID("lightsensor")
            vc.title = "Light Sensors"
            
            lightSensorWindowController = NSWindowController(window: NSWindow(contentViewController: vc))
            lightSensorWindowController?.showWindow(self)
        } else {
            lightSensorWindowController?.showWindow(self)
        }
	}
    
	@IBAction func compassActions(_ sender: Any) {
        if compassWindowController == nil {
            let vc = getViewControllerFromID("compass")
            vc.title = "Compass"
            
            compassWindowController = NSWindowController(window: NSWindow(contentViewController: vc))
            compassWindowController?.showWindow(self)
        } else {
            compassWindowController?.showWindow(self)
        }
	}
    
	@IBAction func tsopAction(_ sender: Any) {
        if tsopWindowController == nil {
            let vc = getViewControllerFromID("tsop")
            vc.title = "TSOP"
            
            tsopWindowController = NSWindowController(window: NSWindow(contentViewController: vc))
            tsopWindowController?.showWindow(self)
        } else {
            tsopWindowController?.showWindow(self)
        }
    }
    
    func getViewControllerFromID(_ id: String) -> NSViewController {
        return NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: id) as! NSViewController
    }
    
	@IBAction func dumpBluetooth(_ sender: Any) {
        let bt = BluetoothController.shared
        
        let array = [bt.bluetoothDebug, bt.connected]
        let debugString = "[BLUETOOTH] - \(array)"
		MKULog.shared.debug(debugString)
        BluetoothController.shared.messageDelegate?.showInformation(debugString)
	}
	
	@IBAction func scanForDevicesAction(_ sender: Any) {
        BluetoothController.shared.connectCount = 0
		BluetoothController.shared.connect()
	}
}
