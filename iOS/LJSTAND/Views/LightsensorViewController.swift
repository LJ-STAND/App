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
    @IBOutlet weak var lightSensView: lightSensorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lightSensView.drawLights(numberOfLights: 24)
        
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
    var lights: [lightSensor] = []
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.lightGray
        self.makeCircular()
    }
    
    func drawLights(numberOfLights: Int) {
        
        for light in lights {
            light.removeFromSuperview()
        }
        
        lights = []
        
        let interval = Double(360/numberOfLights)
        let hypt = Double(self.frame.width/2 - 30)
        
        for i in 1...numberOfLights {
            
            //Maths stuffs
            let angle = (interval * Double(i)) - 105
            let angleRad = (angle * M_PI / 180.0)
            
            let radOfLight = 15.0
            let offset = radOfLight / 2.0
            
            let hei = (hypt * sin(angleRad)) + Double(self.frame.height / 2) - offset
            let wid = (hypt * cos(angleRad)) + Double(self.frame.width / 2) - offset
            
            
            let tempLight = lightSensor(frame: CGRect(x: wid, y: hei, width: radOfLight, height: radOfLight))
            tempLight.setLight()
            self.addSubview(tempLight)
            
            lights.append(tempLight)
        }
    }
    
    func setValues(sensorNumber: Int) {
        let sensor = lights[sensorNumber]
        sensor.enabled = true
        sensor.setLight()
    }
    
    func clearValues() {
        for item in lights {
            item.enabled = false
            item.setLight()
        }
    }
}

class lightSensor: UIView {
    var enabled = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
        self.makeCircular()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setLight() {
        if (enabled) {
            self.backgroundColor = .green
        } else {
            self.backgroundColor = .black
        }
    }
    
}
