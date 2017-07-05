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
        
        if BluetoothController.shared.fakeData {
            let data = BluetoothControllerFakeData.pixy
            self.updatedGoalInformation(x: data[0], y: data[1], width: data[2], height: data[3])
        }
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
        pixyView.applyNewPixyData(x: x, y: y, width: width, height: height)
    }
}
