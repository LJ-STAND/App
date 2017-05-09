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
    var windowView: WindowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BluetoothController.shared.robotPositionDelegate = self
        
        super.viewDidLoad()
        
        robotPos = RobotPositionView(frame: calculateFrame())
        
        windowView = WindowView(frame: self.view.frame)
        self.view = windowView
        
        windowView.contentView = robotPos
        windowView.title = "ROBOT POSITION"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        windowWasResized()
        
//        Test View
        MKUAsync.background {
            for i in 0...24 {
                MKUAsync.main { self.updatePosition(position: RobotPosition(rawValue: i)!) }
                sleep(1)
            }
        }
    }
    
    func calculateFrame() -> CGRect {
        let windowFrame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 44.0, width: self.view.frame.width, height: self.view.frame.height - 44.0)
        let maxSize = windowFrame.size.width > windowFrame.size.height ? windowFrame.size.height * 0.9 : windowFrame.size.width * 0.9
        let returnFrame = CGRect(x: windowFrame.origin.x + windowFrame.size.width / 2 - maxSize / 2, y: windowFrame.origin.y + windowFrame.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        
        return returnFrame
    }
    
    func windowWasResized() {
        windowView.resize()
        robotPos.setNeedsDisplay()
    }
}

extension RobotPositionViewController: BluetoothControllerRobotPositionDelegate {
    func updatePosition(position: RobotPosition) {
        self.robotPos.setRobotPosition(position)
    }
}
