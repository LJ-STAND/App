//
//  ViewController.swift
//  LJ STAND macOS
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa

class MacOSViewController: NSViewController, BluetoothControllerLightSensorDelegate {
	@IBOutlet weak var lightSensor: lightSensorView!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
        BluetoothController.shared.lightSensDelegate = self
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

    func updatedCurrentLightSensors(_ sensors: [Int]) {
        lightSensor.clearValues()
        
        for item in sensors {
            lightSensor.setValues(item)
        }
    }
}
