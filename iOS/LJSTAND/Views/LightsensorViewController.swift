//
//  LightsensorViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 14/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import MKUtilityKit
@IBOutlet weak var lsView: lightSensorView!
import MKUIKit
import Chameleon
import QuartzCore

class LightSensorViewController: UIViewController, ResizableViewController {
    internal var tappedButton: UIButton?
    
    var lightSensView: lightSensorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BluetoothController.shared.lightSensDelegate = self

        super.viewDidLoad()
        
        lightSensView = lightSensorView(frame: calculateFrame())
        
        self.view.addSubview(lightSensView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        windowWasResized()
    }
    
    func calculateFrame() -> CGRect {
        let windowFrame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 44.0, width: self.view.frame.width, height: self.view.frame.height - 44.0)
        let maxSize = windowFrame.size.width > windowFrame.size.height ? windowFrame.size.height * 0.9 : windowFrame.size.width * 0.9
        let returnFrame = CGRect(x: windowFrame.origin.x + windowFrame.size.width / 2 - maxSize / 2, y: windowFrame.origin.y + windowFrame.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        
        return returnFrame
    }
    
    func windowWasResized() {
        lightSensView.frame = calculateFrame()
        lightSensView.setNeedsDisplay()
    }
}

extension LightSensorViewController: BluetoothControllerLightSensorDelegate {
    func updatedCurrentLightSensors(_ sensors: [Int]) {
        self.lightSensView.clearValues()
        
        for item in sensors {
            self.lightSensView.setValues(item)
        }
    }
}
