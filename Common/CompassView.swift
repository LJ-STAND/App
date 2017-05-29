//
//  CompassView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation

#if os(macOS)
    import Cocoa
#elseif os(iOS)
    import UIKit
#endif

@IBDesignable
class CompassView: View {
    
    @IBInspectable var needleAngle: Double!
    @IBInspectable var drawBackground = false
    
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
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        
        if drawBackground {
            Color.white.setFill()
            RectFill(rect)
        }
        
        let maxSize = min(rect.size.width, rect.size.height)
        let square = CGRect(x: rect.origin.x + rect.size.width / 2 - maxSize / 2, y: rect.origin.y + rect.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        let path = BezierPath(ovalIn: CGRect(origin: CGPoint(x: square.origin.x + 0.05 * square.size.width, y: square.origin.y + 0.05 * square.size.width), size: CGSize(width: 0.9 * square.size.width, height: 0.9 * square.size.height)))
        
        if drawBackground {
            Color.black.setStroke()
        } else {
            Color.white.setStroke()
        }
        
        path.lineWidth = 3
        path.stroke()
        
        if !BluetoothController.shared.connected {
            let ovalRect = square.insetBy(dx: 0.9 * (square.size.width / 2), dy: 0.9 * (square.size.height / 2))
            let ovalPath = BezierPath(ovalIn: ovalRect)
            ovalPath.move(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(3*(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(3*(Double.pi / 4)))))

            let ovalPathPoint = Point(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(-(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(-(Double.pi / 4))))
            
            #if os(macOS)
                ovalPath.line(to: ovalPathPoint)
            #else
                ovalPath.addLine(to: ovalPathPoint)
            #endif
            
            Color.red.setStroke()
            ovalPath.lineWidth = 3
            ovalPath.stroke()
        } else {
            let xCenter = Double(self.frame.width / 2)
            let yCenter = Double(self.frame.height / 2)
            
            let angleRadians = degToRad((360 - needleAngle) - 90)
            
            let needleRadius = (0.8 * Double(square.size.width)) / 2
            let xPoint = xCenter + (needleRadius * sin(angleRadians))
            let yPoint = yCenter + (needleRadius * cos(angleRadians))
            
            let needlePath = BezierPath()
            
            needlePath.move(to: CGPoint(x: xCenter, y: yCenter))
            
            let point = Point(x: xPoint, y: yPoint)
            
            #if os(macOS)
                needlePath.line(to: point)
                needlePath.lineCapStyle = .roundLineCapStyle
            #else
                needlePath.addLine(to: point)
                needlePath.lineCapStyle = .round
            #endif
            
            needlePath.lineWidth = 3
            
            needlePath.stroke()
        }
    }
    
    func rotate(_ angle:Double) {
        needleAngle = angle
        setNeedsDisplay(bounds)
    }
    
    func degToRad(_ angle: Double) -> Double {
        return (angle - 90) * Double.pi/180
    }
}
