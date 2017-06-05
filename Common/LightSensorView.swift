//
//  LightSensorView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation
import UIKit

class lightSensorView: UIView {
    var lights: [Bool] = [Bool]()
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
        for _ in 1...24 {
            lights.append(false)
        }
    }
    
    override func draw(_ rect: CGRect) {
        if (drawBackground) {
            UIColor.white.setFill()
            UIRectFill(rect)
        }
        
        
        let maxSize = min(rect.size.width, rect.size.height)
        let square = CGRect(x: rect.origin.x + rect.size.width / 2 - maxSize / 2, y: rect.origin.y + rect.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        
        let numberOfLights = 24
        
        let radOfLight = Double(square.size.width / 20)
        let offset = radOfLight / 2.0
        
        let interval = Double(360 / numberOfLights)
        let hypt = Double(square.size.width / 2) - radOfLight
        
        for i in 0..<numberOfLights {
            let angle = 360 - ((interval * Double(i)) + 90)
            let angleRad = degToRad(angle)
            
            let xVal = (Double(square.midX) + (hypt * sin(angleRad)) - offset)
            let yVal = (Double(square.midY) + (hypt * cos(angleRad)) - offset)
            
            let path = UIBezierPath(ovalIn: CGRect(x: xVal, y: yVal, width: radOfLight, height: radOfLight))
            
            var tempColor = UIColor.white
            
            if drawBackground {
                tempColor = .black
            }
            
            tempColor.setFill()
            tempColor.setStroke()
            
            if lights[i] {
                path.fill()
            } else {
                path.stroke()
            }
        }
        
        if !BluetoothController.shared.connected {
            let ovalRect = square.insetBy(dx: 0.9 * (square.size.width / 2), dy: 0.9 * (square.size.height / 2))
            let ovalPath = UIBezierPath(ovalIn: ovalRect)
            ovalPath.move(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(3*(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(3*(Double.pi / 4)))))
            
            let ovalPathPoint = CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(-(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(-(Double.pi / 4))))
            
            ovalPath.addLine(to: ovalPathPoint)
            
            UIColor.red.setStroke()
            ovalPath.lineWidth = 3
            ovalPath.stroke()
        }
    }
    
    func setValues(_ sensorNumber: Int) {
        lights[sensorNumber] = true
        
        setNeedsDisplay(bounds)
    }
    
    func clearValues() {
        for i in 0..<lights.count {
            lights[i] = false
        }
        
        setNeedsDisplay(bounds)
    }
    
    func degToRad(_ angle: Double) -> Double {
        return (angle - 90) * Double.pi/180
    }
}
