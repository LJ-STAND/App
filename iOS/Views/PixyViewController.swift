//
//  PixyViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 16/6/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class PixyViewController: UIViewController {
    var pixyView: PixyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        pixyView = PixyView(frame: self.view.bounds)
        pixyView.backgroundColor = .gray
        self.view.addSubview(pixyView)
        generateContraints(subView: pixyView, padding: 50.0)
        
        pixyView.applyNewPixyData(x: 0, y: 0, width: 50, height: 50)
    }
}


extension PixyViewController: BluetoothControllerPixyDelegate {
    func updatedGoalInformation(x: Double, y: Double, width: Double, height: Double) {
        pixyView.applyNewPixyData(x: x, y: y, width: width, height: height)
    }
}
