//
//  CompassViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 13/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit

class CompassViewController: UIViewController {
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var compass: CompassView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width - 40
        
//        compass = CompassView(frame: CGRect(x: 20, y: 120, width: width, height: width))
        compass.rotate(angle: 0.0)
        
//        self.view.addSubview(compass)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newCompass), name: NSNotification.Name(rawValue: "newCompass"), object: nil)
    }
    
    func newCompass(notification: Notification) {
        guard let ang = notification.object as? Double else {
            return
        }
        
        compass.rotate(angle: ang)
        angleLabel.text = "Angle: \(ang)"
    }
}


class CompassView: UIView {
    var needle: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.lightGray
//        self.layer.cornerRadius = frame.height/2
//        self.clipsToBounds = true
        self.makeCircular()
        
        self.needle = UIView(frame: CGRect(x: self.frame.width / 4, y: self.frame.height / 2, width: self.frame.width/2, height: 10))
        self.needle.backgroundColor = .green
        self.needle.layer.cornerRadius = 5
        self.needle.clipsToBounds = true
        
        self.needle.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        //        self.needle.frame.origin = self.center
        self.addSubview(needle)
    }
    
    func rotate(angle:Double) {
        let rad = degToRad(angle: angle)
        self.needle.transform = CGAffineTransform(rotationAngle: CGFloat(rad))
        //        self.needle.center = self.center
    }
    
    func degToRad(angle: Double) -> Double {
        return (angle - 90) * M_PI/180
    }
}
