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
    func hasNewHeading(angle: Double) {
        UIView.animate(withDuration: 0.025, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.compass.rotate(angle: angle)
        })
    }
}


class CompassView: UIView {
    var needleAngle: Double!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        needleAngle = 0
    }
    
    override func draw(_ rect: CGRect) {
        let backgroundPath = UIBezierPath(rect: rect)
        UIColor.white.setFill()
        backgroundPath.fill()
        
        let path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: rect.origin.x + 0.05 * rect.size.width, y: rect.origin.y + 0.05 * rect.size.width), size: CGSize(width: 0.9 * rect.size.width, height: 0.9 * rect.size.height)))
        UIColor.flatBlack().setStroke()
        path.lineWidth = 3
        path.stroke()
        
        if !BluetoothController.shared.connected {
            let ovalRect = rect.insetBy(dx: 0.9 * (rect.size.width / 2), dy: 0.9 * (rect.size.height / 2))
            let ovalPath = UIBezierPath(ovalIn: ovalRect)
            ovalPath.move(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(3*M_PI_4)), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(3*M_PI_4))))
            ovalPath.addLine(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(-M_PI_4)), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(-M_PI_4))))
            
            UIColor.flatRed().setStroke()
            ovalPath.lineWidth = 3
            ovalPath.stroke()
        } else {
            let xCenter = Double(self.frame.width / 2)
            let yCenter = Double(self.frame.height / 2)
            
            let angleRadians = degToRad(angle: needleAngle - 90)
            
            let needleRadius = (0.8 * Double(self.frame.width)) / 2
            let xPoint = xCenter + (needleRadius * sin(angleRadians))
            let yPoint = yCenter + (needleRadius * cos(angleRadians))
            
            let needlePath = UIBezierPath()
            
            needlePath.move(to: CGPoint(x: xCenter, y: yCenter))
            needlePath.addLine(to: CGPoint(x: xPoint, y: yPoint))
            
            needlePath.lineWidth = 3
            needlePath.lineCapStyle = .round
            
            needlePath.stroke()
        }
    }
    
    func rotate(angle:Double) {
        needleAngle = angle
        setNeedsDisplay()
    }
    
    func degToRad(angle: Double) -> Double {
        return (angle - 90) * M_PI/180
    }
}
