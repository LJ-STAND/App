//
//  BackgroundViewController.swift
//  LJ STAND
//
//  Created by James Yelland on 6/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class BackgroundViewController: UIViewController {
    var serialButton: HexButton!
    var TSOPButton: HexButton!
    var lightButton: HexButton!
    var compassButton: HexButton!
    var designButton: HexButton!
    
    @IBOutlet weak var dockView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: dockView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSizeMake(5.0, 5.0)).cgPath
        maskLayer.frame = dockView.bounds
        dockView.layer.mask = maskLayer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonTapped(_ sender: UIButton) {
        if let hexButton = sender as? HexButton {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWindow"), object: hexButton.text)
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        let dockHeight = self.view.frame.height / 10
        dockView.frame = CGRect(x: 0.0, y: self.view.frame.height - dockHeight, width: self.view.frame.width, height: dockHeight)
    }
}
