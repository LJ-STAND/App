//
//  TSOPViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa

class TSOPViewController: NSViewController {
    @IBOutlet weak var tsView: TSOPRingView!
    
    override func viewDidLoad() {
        BluetoothController.shared.tsopDelegate = self
        tsView.drawBackground = true
        tsView.setNeedsDisplay(tsView.bounds)
    }
    
    deinit {
        BluetoothController.shared.tsopDelegate = nil
    }
}

extension TSOPViewController: BluetoothControllerTSOPDelegate {
    func hasNewActiveTSOP(_ tsopNum: Int) {
        tsView.setCurrent(tsopNum)
    }
}
