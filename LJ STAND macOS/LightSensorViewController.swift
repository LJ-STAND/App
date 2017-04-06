//
//  LightSensorViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa

class LightSensorViewController: NSViewController {
	@IBOutlet weak var lsView: lightSensorView!
    
    override func viewDidLoad() {
        BluetoothController.shared.lightSensDelegate = self
    }
    
    deinit {
        BluetoothController.shared.lightSensDelegate = nil
    }
}

extension LightSensorViewController: BluetoothControllerLightSensorDelegate {
    func updatedCurrentLightSensors(_ sensors: [Int]) {
        lsView.clearValues()
        
        for item in sensors {
            lsView.setValues(item)
        }
    }
}
