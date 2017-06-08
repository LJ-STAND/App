//
//  CompassView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation
import UIKit

class CompassView: UIView {
    
    var needleAngle: Double!
    var drawBackground = false
    var secondNeedleAngle: Double!
    var drawSecondNeedle = false
    
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
        needleAngle = 0
        secondNeedleAngle = 0
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        
        if drawBackground {
            UIColor.white.setFill()
            UIRectFill(rect)
        }
        
        let maxSize = min(rect.size.width, rect.size.height)
        let square = CGRect(x: rect.origin.x + rect.size.width / 2 - maxSize / 2, y: rect.origin.y + rect.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        let path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: square.origin.x + 0.05 * square.size.width, y: square.origin.y + 0.05 * square.size.width), size: CGSize(width: 0.9 * square.size.width, height: 0.9 * square.size.height)))
        
        if drawBackground {
            UIColor.black.setStroke()
        } else {
            UIColor.white.setStroke()
        }
        
        path.lineWidth = 3
        path.stroke()
        
        if !BluetoothController.shared.connected {
            let ovalRect = square.insetBy(dx: 0.9 * (square.size.width / 2), dy: 0.9 * (square.size.height / 2))
            let ovalPath = UIBezierPath(ovalIn: ovalRect)
            ovalPath.move(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(3*(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(3*(Double.pi / 4)))))

            let ovalPathPoint = CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(-(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(-(Double.pi / 4))))
            
            ovalPath.addLine(to: ovalPathPoint)
            
            UIColor.red.setStroke()
            ovalPath.lineWidth = 3
            ovalPath.stroke()
        } else {
            let xCenter = Double(self.frame.width / 2)
            let yCenter = Double(self.frame.height / 2)
            
            let angleRadians = degToRad((360 - needleAngle) - 90)
            
            let needleRadius = (0.8 * Double(square.size.width)) / 2
            let xPoint = xCenter + (needleRadius * sin(angleRadians))
            let yPoint = yCenter + (needleRadius * cos(angleRadians))
            
            let needlePath = UIBezierPath()
            
            needlePath.move(to: CGPoint(x: xCenter, y: yCenter))
            
            let point = CGPoint(x: xPoint, y: yPoint)
            
            needlePath.addLine(to: point)
            needlePath.lineCapStyle = .round
            
            needlePath.lineWidth = 3
            
            needlePath.stroke()
            
            
            if drawSecondNeedle {
                UIColor.green.setStroke()
                
                let twoAngleRads = degToRad((360 - secondNeedleAngle) - 90)
                
                let xPointTwo = xCenter + (needleRadius * sin(twoAngleRads))
                let yPointTwo = yCenter + (needleRadius * cos(twoAngleRads))
                
                let secondNeedlePath = UIBezierPath()
                
                secondNeedlePath.move(to: CGPoint(x: xCenter, y: yCenter))
                
                let secpoint = CGPoint(x: xPointTwo, y: yPointTwo)
                
                secondNeedlePath.addLine(to: secpoint)
                secondNeedlePath.lineCapStyle = .round
                
                secondNeedlePath.lineWidth = 3
                
                secondNeedlePath.stroke()

            }
            
        }
    }
    
    func rotate(_ angle:Double) {
        needleAngle = angle
        setNeedsDisplay(bounds)
    }
    
    func rotateSecondNeedle(_ angle: Double) {
        secondNeedleAngle = angle
        drawSecondNeedle = true
        setNeedsDisplay(bounds)
    }
    
    func degToRad(_ angle: Double) -> Double {
        return (angle - 90) * Double.pi/180
    }
}
