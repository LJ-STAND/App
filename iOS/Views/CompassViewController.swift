//
//  CompassViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 13/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import MKUtilityKit
import MKUIKit

class CompassViewController: UIViewController {
    internal var tappedButton: UIButton?

    var compass: CompassView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        compass = CompassView(frame: calculateFrame())
        
        self.view.addSubview(compass)
        
        self.generateConstraints(subView: compass)
        
        if BluetoothController.shared.fakeData {
            self.hasNewHeading(BluetoothControllerFakeData.compassAngle, robot: .noRobot)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BluetoothController.shared.compassDelegate = self
        windowWasResized()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        BluetoothController.shared.compassDelegate = nil
    }
    
    func calculateFrame() -> CGRect {
        let windowFrame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 44.0, width: self.view.frame.width, height: self.view.frame.height - 44.0)
        let maxSize = windowFrame.size.width > windowFrame.size.height ? windowFrame.size.height * 0.9 : windowFrame.size.width * 0.9
        let returnFrame = CGRect(x: windowFrame.origin.x + windowFrame.size.width / 2 - maxSize / 2, y: windowFrame.origin.y + windowFrame.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        
        return returnFrame
    }
    
    func windowWasResized() {
        compass.setNeedsDisplay()
    }
}

extension CompassViewController: BluetoothControllerCompassDelegate {
    func hasNewHeading(_ angle: Double, robot: RobotNumber) {
        self.compass.rotate(angle)
    }
}
