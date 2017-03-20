//
//  SettingsTableViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 27/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import MKUIKit
import MKUtilityKit

class SettingsTableViewController: UITableViewController {
	@IBOutlet weak var logWindowSwitch: UISwitch!
	@IBOutlet weak var dockOnRightSwitch: UISwitch!
    let defaults = MKUDefaults(suiteName: MKAppGroups.LJSTAND).defaults
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logWindowSwitch.isOn = defaults.bool(forKey: DefaultKeys.showLog)
        dockOnRightSwitch.isOn = defaults.bool(forKey: DefaultKeys.isDockOnRight)
    }

	@IBAction func logWindowAction(_ sender: Any) {
        let value = logWindowSwitch.isOn
        
        if value == true {
            delegate.addWindow(viewName: "App Log")
        } else {
            delegate.removeWindow(name: "App Log")
        }
        
        defaults.set(value, forKey: DefaultKeys.showLog)
	}
	
	@IBAction func dockOnRightAction(_ sender: Any) {
		let value = dockOnRightSwitch.isOn
        
        defaults.set(value, forKey: DefaultKeys.isDockOnRight)
        delegate.setFrames()
        delegate.orientationDidChange()
	}
}
