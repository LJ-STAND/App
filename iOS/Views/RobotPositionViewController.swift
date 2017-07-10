//
//  RobotPositionViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 8/5/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import MKUtilityKit
import MKUIKit

class RobotPositionViewController: UIViewController {
    var robotPos: RobotPositionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        robotPos = RobotPositionView(frame: calculateFrame())
        
        self.view.backgroundColor = .clear
        self.view.addSubview(robotPos)
        self.generateConstraints(subView: robotPos)
        
        if BluetoothController.shared.fakeData {
            self.updatePosition(angle: BluetoothControllerFakeData.positionAngle, size: BluetoothControllerFakeData.positionSize, robot: RobotNumber.noRobot)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        windowWasResized()
        BluetoothController.shared.robotPositionDelegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        BluetoothController.shared.robotPositionDelegate = nil
    }
    
    func calculateFrame() -> CGRect {
        let windowFrame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 44.0, width: self.view.frame.width, height: self.view.frame.height - 44.0)
        let maxSize = windowFrame.size.width > windowFrame.size.height ? windowFrame.size.height * 0.9 : windowFrame.size.width * 0.9
        let returnFrame = CGRect(x: windowFrame.origin.x + windowFrame.size.width / 2 - maxSize / 2, y: windowFrame.origin.y + windowFrame.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        
        return returnFrame
    }
    
    func windowWasResized() {
        robotPos.setNeedsDisplay()
    }
}

extension RobotPositionViewController: BluetoothControllerRobotPositionDelegate {
    func updatePosition(angle: Double, size: Double, robot: RobotNumber) {
        robotPos.applyData(angle: angle, size: size)
    }
}
