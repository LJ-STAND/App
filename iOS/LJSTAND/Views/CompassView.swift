//
//  CompassView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 13/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit

class CompassView: UIView {
    var needle: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = frame.width/2
        self.clipsToBounds = true
        
        self.needle = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width/2, height: 10))
        self.needle.backgroundColor = .green
        self.needle.layer.cornerRadius = 5
        self.needle.clipsToBounds = true
        
        self.needle.layer.anchorPoint = CGPoint(x: 0, y: 0)
        self.needle.frame.origin = self.center
        self.addSubview(needle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(angle:Double) {
        let rad = degToRad(angle: angle)
        self.needle.transform = CGAffineTransform(rotationAngle: CGFloat(rad))
    }
    
    func degToRad(angle: Double) -> Double {
        return (angle - 90) * M_PI/180
    }
}
