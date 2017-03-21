//
//  CompassViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa
import MKUtilityKit

class CompassViewController: NSViewController {
    @IBOutlet weak var compassView: CompassView!
    
    override func viewDidLoad() {
        BluetoothController.shared.connected = true
        BluetoothController.shared.compassDelegate = self
        BluetoothController.shared.messageDelegate?.showInformation("Set Compass Delegate")
    }
}

extension CompassViewController: BluetoothControllerCompassDelegate {
    func hasNewHeading(_ angle: Double) {
        compassView.rotate(angle)
    }
}
