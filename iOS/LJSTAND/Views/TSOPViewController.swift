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

class TSOPViewController: UIViewController {
    
    @IBOutlet weak var tsopLabel: UILabel!
    @IBOutlet weak var tsopView: circularView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tsopView.drawTSOPS(numberOfTSOPS: 24)
        tsopView.setCurrent(current: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newActive), name: NSNotification.Name(rawValue: "newActive"), object: nil)
    }
    
    func newActive(notification: Notification) {
        guard let tsopNum = notification.object as? Int else {
            return
        }
        
        tsopLabel.text = "Current TSOP: \(tsopNum)"
        tsopView.setCurrent(current: tsopNum)
    }

}

class circularView: UIView {
    var tsops: [tsop] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.lightGray
//        self.layer.cornerRadius = frame.width/2
//        self.clipsToBounds = true
        self.makeCircular()
    }
    
    func drawTSOPS(numberOfTSOPS: Int) {
        
        for tsp in tsops {
            tsp.removeFromSuperview()
        }
        
        tsops = []
        
        let interval = Double(360/numberOfTSOPS)
        let hypt = Double(self.frame.width/2 - 30)
        
        for i in 1...numberOfTSOPS {
            
            //Maths stuffs
            let angle = (interval * Double(i)) - 105
            let angleRad = (angle * M_PI / 180.0)
            
            let radOfTSOP = 15.0
            let offset = radOfTSOP / 2.0
            
            let hei = (hypt * sin(angleRad)) + Double(self.frame.height / 2) - offset
            let wid = (hypt * cos(angleRad)) + Double(self.frame.width / 2) - offset
            
            
            let tempTSOP = tsop(frame: CGRect(x: wid, y: hei, width: radOfTSOP, height: radOfTSOP))
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
}

class tsop: UIView {
    var current = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
//        self.layer.cornerRadius = frame.width/2
//        self.clipsToBounds = true
        self.makeCircular()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setTSOP() {
        if (current) {
            self.backgroundColor = .green
        } else {
            self.backgroundColor = .black
        }
    }
    
}

