//
//  TSOPViewController.swift
//  LJSTAND
//
//  Created by Lachlan Grant on 12/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import CoreBluetooth
import MKKit


class TSOPViewController: UIViewController {
    
    @IBOutlet weak var tsopLabel: UILabel!
    var tsopView: circularView = circularView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.view.frame.width - 40
        
        tsopView = circularView(frame: CGRect(x: 20, y: 120, width: width, height: width))
        tsopView.drawTSOPS(numberOfTSOPS: 24)
        tsopView.setCurrent(current: 0)
        
        self.view.addSubview(tsopView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newActive), name: NSNotification.Name(rawValue: "newActive"), object: nil)
    }
    
    func newActive(notification: Notification) {
        guard let tsopNum = notification.object as? Int else {
            return
        }
        
        tsopLabel.text = "Current TSOP: \(tsopNum)"
        tsopView.setCurrent(current: tsopNum)
    }

}
