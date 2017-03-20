//
//  InitialViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa

class InitialViewController: NSViewController {
    
	@IBAction func serialAction(_ sender: Any) {
        
	}
    
	@IBAction func lightSensorsAction(_ sender: Any) {
        let viewID = "lightsensor"
        
        let lightSensor = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: viewID) as! NSViewController
        
        lightSensor.title = "Light Sensors"
        
        self.presentViewControllerAsModalWindow(lightSensor)
	}
    
	@IBAction func compassActions(_ sender: Any) {
        
	}
    
	@IBAction func tsopAction(_ sender: Any) {
        
    }
}
