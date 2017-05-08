//
//  RobotPositionViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 8/5/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa
import MKUtilityKit

class RobotPositionViewController: NSViewController {
    @IBOutlet weak var robotPosView: RobotPositionView!
    
    override func viewDidLoad() {
        BluetoothController.shared.robotPositionDelegate = self
        robotPosView.setNeedsDisplay(robotPosView.bounds)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()

//      Test View
//        MKUAsync.background {
//            for i in 0...24 {
//                MKUAsync.main { self.updatePosition(position: RobotPosition(rawValue: i)!) }
//                sleep(1)
//            }
//        }
    }
    
    deinit {
        BluetoothController.shared.robotPositionDelegate = nil
    }
}

extension RobotPositionViewController: BluetoothControllerRobotPositionDelegate {
    func updatePosition(position: RobotPosition) {
        robotPosView.setRobotPosition(pos: position)
    }
}
