//
//  TSOPViewController.swift
//  LJSTAND
//
//  Created by Lachlan Grant on 12/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import CoreBluetooth
import MKKit
import MKUIKit
import MKUtilityKit
import QuartzCore
import Chameleon

class TSOPViewController: UIViewController {
    internal var tappedButton: UIButton?
    var tsopView: CompassView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        tsopView = CompassView(frame: calculateFrame())
        
        self.view.addSubview(tsopView)
        self.generateConstraints(subView: tsopView)
        
        if BluetoothController.shared.fakeData {
            self.hasNewOrbitAngle(BluetoothControllerFakeData.tsopOrbit, robot: .noRobot)
            self.hasNewDirection(BluetoothControllerFakeData.tsopDirection, robot: .noRobot)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(TSOPViewController.redrawSubView), name: NotificationKeys.resizedWindow, object: nil)
    }
    
    @objc func redrawSubView() {
        MKULog.shared.debug("Redrawing TSOP")
        tsopView.draw(tsopView.frame)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        windowWasResized()
        BluetoothController.shared.tsopDelegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        BluetoothController.shared.tsopDelegate = nil
    }
    
    func windowWasResized() {
        tsopView.setNeedsDisplay()
    }
    
    func calculateFrame() -> CGRect {
        let windowFrame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 44.0, width: self.view.frame.width, height: self.view.frame.height - 44.0)
        let maxSize = windowFrame.size.width > windowFrame.size.height ? windowFrame.size.height * 0.9 : windowFrame.size.width * 0.9
        let returnFrame = CGRect(x: windowFrame.origin.x + windowFrame.size.width / 2 - maxSize / 2, y: windowFrame.origin.y + windowFrame.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        
        return returnFrame
    }
}

extension TSOPViewController: BluetoothControllerTSOPDelegate {
    func hasNewDirection(_ angle: Double, robot: RobotNumber) {
        tsopView.rotate(angle)
    }
    
    func hasNewOrbitAngle(_ angle: Double, robot: RobotNumber) {
        tsopView.rotateSecondNeedle(angle)
    }
}

