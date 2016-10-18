//
//  TSOPViewController.swift
//  LJSTAND
//
//  Created by Lachlan Grant on 12/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import CoreBluetooth
import MKKit
import QuartzCore
import Chameleon

class TSOPViewController: UIViewController {
    
    @IBOutlet weak var tsopLabel: UILabel!
    var tsopView: tsopRingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dist = min(self.view.frame.width, self.view.frame.height) - (0.2 * self.view.frame.height)
        let maxDimention = CGSize(width: dist, height: dist)
        let origin = CGPoint(x: ((self.view.frame.width / 2) - (dist / 2)), y: ((self.view.frame.height / 2) - (dist / 2)))

        tsopView = tsopRingView(frame: CGRect(origin: origin, size: maxDimention))
        
        self.view.addSubview(tsopView)
        
        tsopView.drawTSOPS(numberOfTSOPS: 24)
        tsopView.setCurrent(current: 0)
        
        let rad = 105 * M_PI/180
        self.tsopView.transform = CGAffineTransform(rotationAngle: CGFloat(rad))
        
        let notif = Notification.Name(rawValue: "newActive")
        NotificationCenter.default.addObserver(self, selector: #selector(self.newActive), name: notif, object: nil)
    }
    
    func newActive(notification: Notification) {
        guard let tsopNum = notification.object as? Int else {
            return
        }
        
        tsopLabel.text = "Current TSOP: \(tsopNum)"
        tsopView.setCurrent(current: tsopNum)
    }

}

class tsopRingView: UIView {
    var tsops: [tsop] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.flatGray()
        self.makeCircular()
    }
    
    func drawTSOPS(numberOfTSOPS: Int) {
        
        let radOfTSOP = 15.0
        let offset = radOfTSOP / 2.0
        
        for tsp in tsops {
            tsp.removeFromSuperview()
        }
        
        tsops = []
        
        let interval = Double(360/numberOfTSOPS)
        let hypt = Double(self.frame.width/2) - radOfTSOP
        
        for i in 1...numberOfTSOPS {
            
            let angle = (interval * Double(i)) - degToRad(angle: 90.0)
            let angleRad = degToRad(angle: angle)
            
            let xVal = (Double(self.frame.width/2) + (hypt * sin(angleRad)) - offset)
            let yVal = (Double(self.frame.height/2) + (hypt * cos(angleRad)) - offset)
            
            let tempTSOP = tsop(frame: CGRect(x: xVal, y: yVal, width: radOfTSOP, height: radOfTSOP))
            tempTSOP.setTSOP()
            self.addSubview(tempTSOP)
            
            tsops.append(tempTSOP)
        }
    }
    
    func setCurrent(current: Int) {
        
        for tSP in tsops {
            tSP.current = false
            tSP.setTSOP()
        }
        
        let curr = tsops[current]
        
        curr.current = true
        curr.setTSOP()
    }
    
    func degToRad(angle: Double) -> Double {
        return (angle - 90) * M_PI/180
    }
}

class tsop: UIView {
    var current = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.flatBlack()
        self.makeCircular()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setTSOP() {
        if (current) {
            self.backgroundColor = .flatGreen()
        } else {
            self.backgroundColor = .flatBlack()
        }
    }
    
}

