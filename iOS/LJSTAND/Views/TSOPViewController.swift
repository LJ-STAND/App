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
    
    var tsopView: tsopRingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BluetoothController.shared.tsopDelegate = self
        
        var multiplyer = CGFloat(0.1)
        if UIDevice.current.userInterfaceIdiom == .pad {
            multiplyer = CGFloat(0.3)
        }
        
        let dist = min(self.view.frame.width, self.view.frame.height) - (multiplyer * self.view.frame.height)
        let maxDimention = CGSize(width: dist, height: dist)
        let origin = CGPoint(x: ((self.view.frame.width / 2) - (dist / 2)), y: ((self.view.frame.height / 2) - (dist / 2)))

        tsopView = tsopRingView(frame: CGRect(origin: origin, size: maxDimention))
        
        self.view.addSubview(tsopView)
    }

}

extension TSOPViewController: BluetoothControllerTSOPDelegate {
    func hasNewActiveTSOP(tsopNum: Int) {
        tsopView.setCurrent(current: tsopNum)
    }
}

class tsopRingView: UIView {
    var tsops: [Bool] = [Bool]()
    
    var tsopNumberLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        tsopNumberLabel = UILabel(frame: CGRect(origin: bounds.origin, size: frame.size))
        tsopNumberLabel.font = tsopNumberLabel.font.withSize(50)
        tsopNumberLabel.textColor = UIColor.flatBlack()
        tsopNumberLabel.textAlignment = .center
        
        tsopNumberLabel.text = "No Data"
        
        addSubview(tsopNumberLabel)
        
        for _ in 1...24 {
            tsops.append(false)
        }
        
        setCurrent(current: -1)
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.white.setFill()
        
        path.fill()
        
        let numberOfTSOPS = 24
        
        let radOfTSOP = 15.0
        let offset = radOfTSOP / 2.0
        
        let interval = Double(360 / numberOfTSOPS)
        let hypt = Double(self.frame.width/2) - radOfTSOP
        
        for i in 0..<numberOfTSOPS {
            let angle = 360 - ((interval * Double(i)) + 90)
            let angleRad = degToRad(angle: angle)
            
            let xVal = (Double(self.frame.width/2) + (hypt * sin(angleRad)) - offset)
            let yVal = (Double(self.frame.height/2) + (hypt * cos(angleRad)) - offset)
            
            let path = UIBezierPath(ovalIn: CGRect(x: xVal, y: yVal, width: radOfTSOP, height: radOfTSOP))
            UIColor.flatBlack().setFill()
            UIColor.flatBlack().setStroke()
            
            if tsops[i] {
                path.fill()
            } else {
                path.stroke()
            }
        }
    }
    
    func setCurrent(current: Int) {
        
        for i in 0..<tsops.count {
            tsops[i] = false
        }
        
        if (current != -1) {
            tsops[current] = true
            tsopNumberLabel.text = "\(current)"
        } else {
            tsopNumberLabel.text = "No Data"
        }
        
        setNeedsDisplay()
    }
    
    func degToRad(angle: Double) -> Double {
        return (angle - 90) * M_PI/180
    }
}

