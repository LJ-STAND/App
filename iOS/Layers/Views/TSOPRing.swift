//
//  TSOPRing.swift
//  LJSTAND
//
//  Created by Lachlan Grant on 12/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import QuartzCore

class circularView: UIView {
    var tsops: [tsop] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = frame.width/2
        self.clipsToBounds = true
        drawTSOPS(numberOfTSOPS: 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawTSOPS(numberOfTSOPS: Int) {
        
        for tsp in tsops {
            tsp.removeFromSuperview()
            
        }
        
        tsops = []
        
        let interval = Double(360/numberOfTSOPS)
        let hypt = Double(self.frame.width - 200)
        
        
        for i in 1...numberOfTSOPS {
            
            //Maths stuffs
            let angle = (interval * Double(i)) - 105
            let angleRad = (angle * M_PI / 180.0)
            
            let hei = (hypt * sin(angleRad)) + Double(self.frame.height / 2) - 15
            let wid = (hypt * cos(angleRad)) + Double(self.frame.width / 2) - 15
            
            
            let tempTSOP = tsop(frame: CGRect(x: wid, y: hei, width: 30, height: 30))
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
        self.layer.cornerRadius = frame.width/2
        self.clipsToBounds = true
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
