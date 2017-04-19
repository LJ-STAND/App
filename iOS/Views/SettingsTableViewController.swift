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
    @IBOutlet weak var tsopSwitch: UISwitch!
    @IBOutlet weak var lightSwitch: UISwitch!
    @IBOutlet weak var compassSwitch: UISwitch!
    
    let defaults = MKUDefaults(suiteName: MKAppGroups.LJSTAND).defaults
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logWindowSwitch.isOn = defaults.bool(forKey: DefaultKeys.showLog)
        dockOnRightSwitch.isOn = defaults.bool(forKey: DefaultKeys.isDockOnRight)
        BluetoothController.shared.sendingDelegate?.requestSettings()
        BluetoothController.shared.settingsDelegate = self
    }

	@IBAction func logWindowAction(_ sender: Any) {
        delegate.setLogWindow(enabled: (sender as! UISwitch).isOn)
	}
	
	@IBAction func dockOnRightAction(_ sender: Any) {
		delegate.setDockOnRight(right: (sender as! UISwitch).isOn)
	}
	
	@IBAction func tsopDebug(_ sender: Any) {
        sendUpdatedSettings()
	}
    
	@IBAction func lightDebug(_ sender: Any) {
		sendUpdatedSettings()
	}
	
	@IBAction func compassDebug(_ sender: Any) {
        sendUpdatedSettings()
	}
    
    func sendUpdatedSettings() {
        BluetoothController.shared.sendingDelegate?.sendSettings(compass: compassSwitch.isOn, tsop: tsopSwitch.isOn, light: lightSwitch.isOn)
    }
}

extension SettingsTableViewController: BluetoothControllerSettingsDelegate {
    func updatedSettings(compass: Bool, light: Bool, tsop: Bool) {
        compassSwitch.isOn = compass
        lightSwitch.isOn = light
        tsopSwitch.isOn = tsop
    }
}