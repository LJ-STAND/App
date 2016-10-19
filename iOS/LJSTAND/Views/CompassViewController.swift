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
    var compass: CompassView!
    
    var titleView: TitleView!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        
        titleView = TitleView(frame: CGRect(origin: CGPoint(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 20.0), size: CGSize(width: self.view.frame.width, height: 80.0)), title: "Compass")
        self.view.addSubview(titleView)
        
        super.viewDidLoad()
        
        let dist = min(self.view.frame.width, self.view.frame.height) - (0.1 * self.view.frame.height)
        let maxDimention = CGSize(width: dist, height: dist)
        let origin = CGPoint(x: ((self.view.frame.width / 2) - (dist / 2)), y: ((self.view.frame.height / 2) - (dist / 2)))
        
        compass = CompassView(frame: CGRect(origin: origin, size: maxDimention))
        
        self.view.addSubview(compass)
        
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
    var needleAngle: Double!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        needleAngle = 0
    }
    
    override func draw(_ rect: CGRect) {
        let backgroundPath = UIBezierPath(rect: rect)
        UIColor.white.setFill()
        
        backgroundPath.fill()
        let path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: rect.origin.x + 0.05 * rect.size.width, y: rect.origin.y + 0.05 * rect.size.width), size: CGSize(width: 0.9 * rect.size.width, height: 0.9 * rect.size.height)))
        UIColor.flatBlack().setStroke()
        path.lineWidth = 3
        path.stroke()
        
        let xCenter = Double(self.frame.width / 2)
        let yCenter = Double(self.frame.height / 2)
        
        let angleRadians = degToRad(angle: 360 - (needleAngle + 90))
        
        let needleRadius = (0.8 * Double(self.frame.width)) / 2
        let xPoint = xCenter + (needleRadius * sin(angleRadians))
        let yPoint = yCenter + (needleRadius * cos(angleRadians))
        
        let needlePath = UIBezierPath()
        
        needlePath.move(to: CGPoint(x: xCenter, y: yCenter))
        needlePath.addLine(to: CGPoint(x: xPoint, y: yPoint))
        
        needlePath.lineWidth = 9
        needlePath.lineCapStyle = .round
        
        needlePath.stroke()
    }
    
    func rotate(angle:Double) {
        needleAngle = angle
        
        setNeedsDisplay()
    }
    
    func degToRad(angle: Double) -> Double {
        return (angle - 90) * M_PI/180
    }
}
