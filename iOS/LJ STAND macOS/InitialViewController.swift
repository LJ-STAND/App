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
        let viewID = "lightsensor"
        let lightSensor = getViewControllerFromID(viewID)
        
        lightSensor.title = "Light Sensors"
        
        self.presentViewControllerAsModalWindow(lightSensor)
	}
    
	@IBAction func compassActions(_ sender: Any) {
        
	}
    
	@IBAction func tsopAction(_ sender: Any) {
        let viewID = "tsop"
        let tsop = getViewControllerFromID(viewID)
        
        tsop.title = "TSOP"
        
        self.presentViewControllerAsModalWindow(tsop)
    }
    
    func getViewControllerFromID(_ id: String) -> NSViewController {
        return NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: id) as! NSViewController
    }
}
