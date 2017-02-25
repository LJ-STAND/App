//
//  DockViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 25/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class DockViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    
    
    func commonAction(name: String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWindow"), object: name)
    }
    
    @IBAction func serialAction(_ sender: Any) {
        commonAction(name: (sender as! HexButton).text)
    }
    
    @IBAction func tsopAction(_ sender: Any) {
        commonAction(name: (sender as! HexButton).text)
    }
    
    @IBAction func lightAction(_ sender: Any) {
        commonAction(name: (sender as! HexButton).text)
    }
    
    @IBAction func compassAction(_ sender: Any) {
        commonAction(name: (sender as! HexButton).text)
    }
    
    @IBAction func designAction(_ sender: Any) {
        commonAction(name: (sender as! HexButton).text)
    }
    
    @IBAction func settingsAction(_ sender: Any) {
//        commonAction(name: (sender as! HexButton).text)
    }
}
