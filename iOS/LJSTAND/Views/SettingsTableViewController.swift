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
	@IBOutlet weak var iconOverlaySwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = MKUDefaults(suiteName: MKAppGroups.LJSTAND).defaults
        
        logWindowSwitch.isOn = defaults.bool(forKey: DefaultKeys.showLog)
        iconOverlaySwitch.isOn = defaults.bool(forKey: DefaultKeys.alternativeIcon)
    }

	@IBAction func updateIcon(_ sender: Any) {
        if #available(iOS 10.3, *) {
            MKULog.shared.info("Running iOS 10.3")
            if (MKUDefaults.init(suiteName: MKAppGroups.LJSTAND).defaults.bool(forKey: DefaultKeys.alternativeIcon)) {
                UIApplication.shared.setAlternateIconName("OverlayIcon") { (error) in
                    if ((error) != nil) {
                        MKUIToast.shared.showNotification(text: (error?.localizedDescription)!, alignment: .center, color: .flatRed, identifier: nil, callback: {})
                        MKULog.shared.error(error?.localizedDescription)
                    }
                }
            } else {
                UIApplication.shared.setAlternateIconName(nil, completionHandler: { (error) in
                    if ((error) != nil) {
                        MKUIToast.shared.showNotification(text: (error?.localizedDescription)!, alignment: .center, color: .flatRed, identifier: nil, callback: {})
                        MKULog.shared.error(error?.localizedDescription)
                    }
                })
            }
            
            
        } else {
            MKUIToast.shared.showNotification(text: "Dynamic Icons is not supported on this version of iOS", alignment: .center, color: .flatBlue, identifier: nil, callback: {})
        }
	}
	
	@IBAction func checkForUpdate(_ sender: Any) {
        MKUAsync.background {
            MKULog.shared.info("Checking for update")
            MKUAppSettings.shared.checkForAppUpdate(urlString: "https://lj-stand.github.io/Apps/config.json", jsonKey: "currentRelease", manifestURL: "https://lj-stand.github.io/Apps/dist/manifest.plist", messageCallback: { (error, message) in
                if error {
                    MKULog.shared.error(message)
                } else {
                    MKULog.shared.info(message)
                }
            }) { (url, message) in
                MKULog.shared.info(message)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            MKULog.shared.mark()
        }
	}
    
	@IBAction func logWindowAction(_ sender: Any) {
        let value = logWindowSwitch.isOn
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        if value == true {
            delegate.logWindow()
        } else {
            delegate.removeWindow(name: "App Log")
        }
        
        let defaults = MKUDefaults.init(suiteName: MKAppGroups.LJSTAND).defaults
        defaults.set(value, forKey: DefaultKeys.showLog)
	}
    
	@IBAction func overlayAction(_ sender: Any) {
        let value = iconOverlaySwitch.isOn
        
        let defaults = MKUDefaults.init(suiteName: MKAppGroups.LJSTAND).defaults
        defaults.set(value, forKey: DefaultKeys.showLog)
        
        updateIcon(sender)
	}
}
