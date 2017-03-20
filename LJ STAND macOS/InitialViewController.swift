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
    
	@IBAction func serialAction(_ sender: Any) {
	}
    
	@IBAction func lightSensorsAction(_ sender: Any) {
        presentViewWithID("lightsensor", title: "Light Sensors")
	}
    
	@IBAction func compassActions(_ sender: Any) {
        presentViewWithID("compass", title: "Compass")
	}
    
	@IBAction func tsopAction(_ sender: Any) {
        presentViewWithID("tsop", title: "TSOP")
    }
    
    func getViewControllerFromID(_ id: String) -> NSViewController {
        return NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: id) as! NSViewController
    }
    
    func presentViewWithID(_ id: String, title: String) {
        let vcToPresent = getViewControllerFromID(id)
        vcToPresent.title = title

        self.presentViewControllerAsModalWindow(vcToPresent)
//        let newWindow = NSWindow(contentViewController: vcToPresent)
//        newWindow.makeKeyAndOrderFront(nil)
    }
	
	@IBAction func dumpBluetooth(_ sender: Any) {
        let bt = BluetoothController.shared
        
        let array = [bt.bluetoothDebug, bt.connected]
		MKULog.shared.info("[BLUETOOTH] - \(array)")
	}
}
