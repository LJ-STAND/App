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
    var compass: CompassView = CompassView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width - 40
        
        compass = CompassView(frame: CGRect(x: 20, y: 120, width: width, height: width))
        compass.rotate(angle: 0.0)
        
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
