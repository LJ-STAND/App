//
//  LightsensorViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 14/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import MKUtilityKit
import MKUIKit
import Chameleon
import QuartzCore

class LightSensorViewController: UIViewController, ResizableViewController {
    internal var tappedButton: UIButton?
    
    var lightSensView: lightSensorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BluetoothController.shared.lightSensDelegate = self

        super.viewDidLoad()
        
        lightSensView = lightSensorView(frame: calculateFrame())
        
        self.view.addSubview(lightSensView)
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
        lightSensView.frame = calculateFrame()
        lightSensView.setNeedsDisplay()
    }
}

extension LightSensorViewController: BluetoothControllerLightSensorDelegate {
    func updatedCurrentLightSensors(sensors: [Int]) {
        self.lightSensView.clearValues()
        
        for item in sensors {
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
