//
//  ViewController.swift
//  LJ STAND macOS
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa

class MacOSViewController: NSViewController, BluetoothControllerLightSensorDelegate {
	@IBOutlet weak var lightSensor: lightSensorView!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
        BluetoothController.shared.lightSensDelegate = self
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

    func updatedCurrentLightSensors(_ sensors: [Int]) {
        lightSensor.clearValues()
        
        for item in sensors {
            lightSensor.setValues(item)
        }
    }
}


@IBDesignable class lightSensorView: NSView {
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
        let path = NSBezierPath(rect: rect)
        NSColor.white.setFill()
        
        path.fill()
        
        let numberOfLights = 24
        
        let radOfLight = Double(self.frame.width / 24)
        let offset = radOfLight / 2.0
        
        let interval = Double(360 / numberOfLights)
        let hypt = Double(self.frame.width/2) - radOfLight
        
        for i in 0..<numberOfLights {
            let angle = 360 - ((interval * Double(i)) + 90)
            let angleRad = degToRad(angle)
            
            let xVal = (Double(self.frame.width/2) + (hypt * sin(angleRad)) - offset)
            let yVal = (Double(self.frame.height/2) + (hypt * cos(angleRad)) - offset)
            
            let path = NSBezierPath(ovalIn: CGRect(x: xVal, y: yVal, width: radOfLight, height: radOfLight))
            NSColor.black.setFill()
            NSColor.black.setStroke()
            
            if lights[i] {
                path.fill()
            } else {
                path.stroke()
            }
        }
        
        if !BluetoothController.shared.connected {
            let ovalRect = rect.insetBy(dx: 0.9 * (rect.size.width / 2), dy: 0.9 * (rect.size.height / 2))
            let ovalPath = NSBezierPath(ovalIn: ovalRect)
            ovalPath.move(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(3*(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(3*(Double.pi / 4)))))
            //            ovalPath.addLine(to: CGPoint(x: ovalRect.midX + (ovalRect.width / 2) * CGFloat(cos(-(Double.pi / 4))), y: ovalRect.midY + (ovalRect.width / 2) * CGFloat(sin(-(Double.pi / 4)))))
            
            NSColor.red.setStroke()
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


