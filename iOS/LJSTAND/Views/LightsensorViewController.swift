//
//  LightsensorViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 14/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import Chameleon
import QuartzCore

class LightSensorViewController: UIViewController {    
    var lightSensView: lightSensorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dist = min(self.view.frame.width, self.view.frame.height) - (0.1 * self.view.frame.height)
        let maxDimention = CGSize(width: dist, height: dist)
        let origin = CGPoint(x: ((self.view.frame.width / 2) - (dist / 2)), y: ((self.view.frame.height / 2) - (dist / 2)))
        
        lightSensView = lightSensorView(frame: CGRect(origin: origin, size: maxDimention))
        
        self.view.addSubview(lightSensView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newData), name: NSNotification.Name(rawValue: "newLights"), object: nil)
    }
    
    func newData(notification: Notification) {
        guard let bools = notification.object as? [Int] else {
            return
        }
        self.lightSensView.clearValues()
        
        for item in bools {
            self.lightSensView.setValues(sensorNumber: item)
        }
    }
}


class lightSensorView: UIView {
    var lights: [Bool] = [Bool]()
 
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
            lights.append(false)
        }
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.white.setFill()
        
        path.fill()
        
        let numberOfLights = 24
        
        let radOfLight = 15.0
        let offset = radOfLight / 2.0
        
        let interval = Double(360 / numberOfLights)
        let hypt = Double(self.frame.width/2) - radOfLight
        
        for i in 0..<numberOfLights {
            let angle = 360 - ((interval * Double(i)) + 90)
            let angleRad = degToRad(angle: angle)
            
            let xVal = (Double(self.frame.width/2) + (hypt * sin(angleRad)) - offset)
            let yVal = (Double(self.frame.height/2) + (hypt * cos(angleRad)) - offset)
            
            let path = UIBezierPath(ovalIn: CGRect(x: xVal, y: yVal, width: radOfLight, height: radOfLight))
            UIColor.flatBlack().setFill()
            UIColor.flatBlack().setStroke()
            
            if lights[i] {
                path.fill()
            } else {
                path.stroke()
            }
        }
    }
    
    func setValues(sensorNumber: Int) {
        lights[sensorNumber] = true
        
        setNeedsDisplay()
    }
    
    func clearValues() {
        for i in 0..<lights.count {
            lights[i] = false
        }
        
        setNeedsDisplay()
    }
    
    func degToRad(angle: Double) -> Double {
        return (angle - 90) * M_PI/180
    }
}
