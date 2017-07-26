//
//  RobotPositionView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 8/5/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation
import UIKit
import MKUtilityKit

class RobotPositionView: UIView {
    var needleAngle: Double = 0.0
    var positionSize: Double = 0.35
    var drawBackground = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        BluetoothController.shared.checkConnect()
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        let maxSize = min(rect.size.width, rect.size.height) * 0.75
        let square = CGRect(x: rect.origin.x + rect.size.width / 2 - maxSize / 2, y: rect.origin.y + rect.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        let path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: square.origin.x + 0.05 * square.size.width, y: square.origin.y + 0.05 * square.size.width), size: CGSize(width: 0.9 * square.size.width, height: 0.9 * square.size.height)))
        
        
        UIColor.flatWhite.setStroke()
        UIColor.flatGreenDark.setFill()
        
        path.lineWidth = 10
        path.stroke()
        path.fill()
        
        
        let xCenter = Double(self.frame.width / 2)
        let yCenter = Double(self.frame.height / 2)
        
        let angleRadians = degToRad((360 - needleAngle) - 90)
        
        let needleRadius = (self.positionSize * Double(maxSize))
        
        var xPoint: Double
        var yPoint: Double
        
        if (self.positionSize == 0.35 && self.needleAngle == 0.0) {
            xPoint = xCenter
            yPoint = yCenter
        } else {
            xPoint = xCenter + (needleRadius * sin(angleRadians))
            yPoint = yCenter + (needleRadius * cos(angleRadians))
        }
        
        let needle = UIBezierPath()
        
        needle.addArc(withCenter: CGPoint(x: xPoint, y: yPoint), radius: CGFloat(self.frame.width * 0.05), startAngle: 0.0, endAngle: (2 * CGFloat.pi), clockwise: true)
        
        needle.lineWidth = 10
        
        UIColor.flatBlack.setFill()
        UIColor.flatWhiteDark.setStroke()
        
        needle.stroke()
        needle.fill()
    }
    
    func rotate(_ angle:Double) {
        needleAngle = angle
        setNeedsDisplay(bounds)
    }
    
    func applyData(angle: Double, size: Double) {
        
        if size == 3.0 {
            //Fully off
            self.positionSize = 0.58
            setNeedsDisplay()
            self.rotate(angle)
        } else if size == 4.0 {
            //Centre
            self.positionSize = 0.0
            setNeedsDisplay()
            self.rotate(angle)
        } else {
            var multiplyer = 0.0
            if size < 0.2 {
                multiplyer = 0.2
            } else {
                multiplyer = size
            }
            
            let actualSize = (multiplyer * 0.09) + 0.35
            self.positionSize = actualSize
            setNeedsDisplay(bounds)
            self.rotate(angle)
        }
        
        
    }
    
    func degToRad(_ angle: Double) -> Double {
        return (angle - 90) * Double.pi/180
    }
}
