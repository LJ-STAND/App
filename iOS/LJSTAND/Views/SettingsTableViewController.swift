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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = MKUDefaults(suiteName: MKAppGroups.LJSTAND).defaults
        
        logWindowSwitch.isOn = defaults.bool(forKey: DefaultKeys.showLog)
    }

	@IBAction func updateIcon(_ sender: Any) {
		let button = sender as! UIButton
		
		let buttonTitle = button.titleLabel?.text
		
		if buttonTitle == "Normal Icon" {
			setIcon(name: nil)
		} else {
			setIcon(name: "Overlay")
		}
	}
	
	func setIcon(name: String?) {
		if #available(iOS 10.3, *) {
			UIApplication.shared.setAlternateIconName(name, completionHandler: { (error) in
				if (error != nil) {
                    MKUIToast.shared.showNotification(text: (error?.localizedDescription)!, alignment: .center, color: .flatRed, identifier: nil, callback: {})
                    MKULog.shared.error(error?.localizedDescription)
				}
			})
        } else {
            MKUIToast.shared.showNotification(text: "Dynamic Icons is not supported on this version of iOS", alignment: .center, color: .flatBlue, identifier: nil, callback: {})
        }
    }
    
	@IBAction func logWindowAction(_ sender: Any) {
        let value = logWindowSwitch.isOn
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        if value == true {
            delegate.addWindow(viewName: "App Log")
        } else {
            delegate.removeWindow(name: "App Log")
        }
        
        let defaults = MKUDefaults.init(suiteName: MKAppGroups.LJSTAND).defaults
        defaults.set(value, forKey: DefaultKeys.showLog)
	}
}
