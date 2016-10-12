//
//  TSOPViewController.swift
//  LJSTAND
//
//  Created by Lachlan Grant on 12/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit

class TSOPViewController: UIViewController {
    var tsopView: circularView = circularView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        tsopView = circularView(frame: CGRect(x: 0, y: 120, width: width, height: width))
        tsopView.drawTSOPS(numberOfTSOPS: 24)
        tsopView.setCurrent(current: 0)
        
        self.view.addSubview(tsopView)
    }
    
    
}
