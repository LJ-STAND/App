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
        //        BluetoothController.shared.checkConnect()
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        
        if drawBackground {
            
        }
        //TODO: Change to flat green
        UIColor.green.setFill()
        UIRectFill(rect)
        
        let maxSize = min(rect.size.width, rect.size.height) * 0.75
        let square = CGRect(x: rect.origin.x + rect.size.width / 2 - maxSize / 2, y: rect.origin.y + rect.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        let path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: square.origin.x + 0.05 * square.size.width, y: square.origin.y + 0.05 * square.size.width), size: CGSize(width: 0.9 * square.size.width, height: 0.9 * square.size.height)))
        
        //        if drawBackground {
        //            UIColor.black.setStroke()
        //        } else {
        //            UIColor.white.setStroke()
        //        }
        
        UIColor.white.setStroke()
        UIColor.green.setFill()
        
        path.lineWidth = 10
        path.stroke()
        
        let temp = false
        
        if /*!BluetoothController.shared.connected*/ temp == true {
            let ovalRect = square.insetBy(dx: 0.9 * (square.size.width / 2), dy: 0.9 * (square.size.height / 2))
            let ovalPath = UIBezierPath(ovalIn: ovalRect)
            ovalPath.move(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(3*(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(3*(Double.pi / 4)))))
            
            let ovalPathPoint = CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(-(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(-(Double.pi / 4))))
            
            ovalPath.addLine(to: ovalPathPoint)
            
            UIColor.red.setStroke()
            ovalPath.lineWidth = 10
            ovalPath.stroke()
        } else {
            let xCenter = Double(self.frame.width / 2)
            let yCenter = Double(self.frame.height / 2)
            
            let angleRadians = degToRad((360 - needleAngle) - 90)
            
            let needleRadius = (self.positionSize * Double(maxSize))
            let xPoint = xCenter + (needleRadius * sin(angleRadians))
            let yPoint = yCenter + (needleRadius * cos(angleRadians))
            
            let dimention = self.frame.width * 0.1
            let cubeXPoint = xPoint - (Double(dimention) / 2)
            let cubeYPoint = yPoint - (Double(dimention) / 2)
            
            let needle = UIBezierPath()
            
            //            needle.move(to: CGPoint(x: xCenter, y: yCenter))
            
            needle.addArc(withCenter: CGPoint(x: xPoint, y: yPoint), radius: CGFloat(self.frame.width * 0.05), startAngle: 0.0, endAngle: (2 * CGFloat.pi), clockwise: true)
            
            needle.lineWidth = 10
            
            UIColor.black.setFill()
            UIColor.black.setStroke()
            
            needle.stroke()
            needle.fill()
            
            //            let needlePath = UIBezierPath()
            //
            //            needlePath.move(to: CGPoint(x: xCenter, y: yCenter))
            //
            //            let point = CGPoint(x: xPoint, y: yPoint)
            //
            //            needlePath.addLine(to: point)
            //            needlePath.lineCapStyle = .round
            //
            //            needlePath.lineWidth = 10
            //
            //            needlePath.stroke()
            
        }
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
