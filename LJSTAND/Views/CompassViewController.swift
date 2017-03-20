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

class CompassViewController: UIViewController, ResizableViewController {
    internal var tappedButton: UIButton?

    var compass: CompassView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BluetoothController.shared.compassDelegate = self
        
        super.viewDidLoad()
        
        compass = CompassView(frame: calculateFrame())
        
        self.view.addSubview(compass)
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
        compass.frame = calculateFrame()
        compass.setNeedsDisplay()
    }
}

extension CompassViewController: BluetoothControllerCompassDelegate {
    func hasNewHeading(_ angle: Double) {
        self.compass.rotate(angle)
    }
}
