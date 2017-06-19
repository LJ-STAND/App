//
//  PixyViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 16/6/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
import MKUtilityKit

class PixyViewController: UIViewController {
    var pixyView: PixyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        pixyView = PixyView(frame: self.view.bounds)
        pixyView.backgroundColor = .gray
        self.view.addSubview(pixyView)
        
        generateContraints(subView: pixyView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BluetoothController.shared.pixyDelegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        BluetoothController.shared.pixyDelegate = nil
    }
}


extension PixyViewController: BluetoothControllerPixyDelegate {
    func updatedGoalInformation(x: Double, y: Double, width: Double, height: Double) {
//        MKULog.shared.debug([x, y, width, height])
        pixyView.applyNewPixyData(x: x, y: y, width: width, height: height)
    }
}
