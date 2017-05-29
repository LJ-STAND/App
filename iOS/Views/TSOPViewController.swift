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
    var windowView: WindowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BluetoothController.shared.tsopDelegate = self
        
        tsopView = CompassView(frame: calculateFrame())
        
        windowView = WindowView(frame: self.view.frame)
        self.view = windowView
        
        windowView.contentView = tsopView
        windowView.title = "TSOP"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        windowWasResized()
    }
    
    func windowWasResized() {
        windowView.resize()
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
    func hasNewDirection(_ angle: Double) {
        tsopView.rotate(angle)
    }
}

