//
//  TSOPRingView.swift
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

class TSOPRingView: View {
    var tsops: [Bool] = [Bool]()
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
        self.backgroundColor = .clear
        
        for _ in 1...24 {
            tsops.append(false)
        }
        
        setCurrent(-1)
    }
    
    override func draw(_ rect: CGRect) {
        if drawBackground {
            Color.white.setFill()
            RectFill(rect)
        }
        let maxSize = min(rect.size.width, rect.size.height)
        let square = CGRect(x: rect.origin.x + rect.size.width / 2 - maxSize / 2, y: rect.origin.y + rect.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        
        let numberOfTSOPS = 24
        
        let radOfTSOP = Double(square.size.width / 20)
        let offset = radOfTSOP / 2.0
        
        let interval = Double(360 / numberOfTSOPS)
        let hypt = Double(square.size.width / 2) - radOfTSOP
        
        for i in 0..<numberOfTSOPS {
            let angle = 360 - ((interval * Double(i)) + 90)
            let angleRad = degToRad(angle)
            
            let xVal = (Double(square.midX) + (hypt * sin(angleRad)) - offset)
            let yVal = (Double(square.midY) + (hypt * cos(angleRad)) - offset)
            
            let path = BezierPath(ovalIn: CGRect(x: xVal, y: yVal, width: radOfTSOP, height: radOfTSOP))
            
            var tempColor = Color.white
            
            if drawBackground {
                tempColor = .black
            }
            
            tempColor.setStroke()
            tempColor.setFill()
            
            if tsops[i] {
                path.fill()
            } else {
                path.stroke()
            }
        }
        
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
        }
    }
    
    func setCurrent(_ current: Int) {
        
        for i in 0..<tsops.count {
            tsops[i] = false
        }
        
        if (current != -1) {
            tsops[current] = true
        }
        
        setNeedsDisplay(bounds)
    }
    
    func degToRad(_ angle: Double) -> Double {
        return (angle - 90) * Double.pi/180
    }
}
