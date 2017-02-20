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

class TSOPViewController: UIViewController, ResizableViewController {
    internal var tappedButton: UIButton?
    
    var tsopView: tsopRingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BluetoothController.shared.tsopDelegate = self
        
        tsopView = tsopRingView(frame: calculateFrame())
        
        self.view.addSubview(tsopView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        windowWasResized()
    }
    
    func windowWasResized() {
        tsopView.frame = calculateFrame()
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
    func hasNewActiveTSOP(_ tsopNum: Int) {
        tsopView.setCurrent(tsopNum)
    }
}

class tsopRingView: UIView {
    var tsops: [Bool] = [Bool]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        for _ in 1...24 {
            tsops.append(false)
        }
        
        setCurrent(-1)
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
            let angleRad = degToRad(angle)
            
            let xVal = (Double(self.frame.width/2) + (hypt * sin(angleRad)) - offset)
            let yVal = (Double(self.frame.height/2) + (hypt * cos(angleRad)) - offset)
            
            let path = UIBezierPath(ovalIn: CGRect(x: xVal, y: yVal, width: radOfTSOP, height: radOfTSOP))
            UIColor.flatBlack.setFill()
            UIColor.flatBlack.setStroke()
            
            if tsops[i] {
                path.fill()
            } else {
                path.stroke()
            }
        }
        
        if !BluetoothController.shared.connected {
            let ovalRect = rect.insetBy(dx: 0.9 * (rect.size.width / 2), dy: 0.9 * (rect.size.height / 2))
            let ovalPath = UIBezierPath(ovalIn: ovalRect)
            ovalPath.move(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(3*(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(3*(Double.pi / 4)))))
            ovalPath.addLine(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(-(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(-(Double.pi / 4)))))
            
            UIColor.flatRed.setStroke()
            ovalPath.lineWidth = 3
            ovalPath.stroke()
        }
    }
    
    func setCurrent(_ current: Int) {
        
        for i in 0..<tsops.count {
            tsops[i] = false
        }
        
        if (current != -1) {
            tsops[current] = true
        }
        
        setNeedsDisplay()
    }
    
    func degToRad(_ angle: Double) -> Double {
        return (angle - 90) * Double.pi/180
    }
}

