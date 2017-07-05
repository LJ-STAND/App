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
import SafariServices

class SettingsTableViewController: UITableViewController {
	@IBOutlet weak var logWindowSwitch: UISwitch!
    @IBOutlet weak var tsopSwitch: UISwitch!
    @IBOutlet weak var lightSwitch: UISwitch!
    @IBOutlet weak var compassSwitch: UISwitch!
    @IBOutlet weak var bluetoothDebug: UISwitch!
    
    let defaults = MKUDefaults(suiteName: MKAppGroups.LJSTAND).defaults
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            tableView.backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            tableView.backgroundView = blurEffectView
            tableView.separatorStyle = .none
        }
        
        logWindowSwitch.isOn = defaults.bool(forKey: DefaultKeys.showLog)
        bluetoothDebug.isOn = defaults.bool(forKey: DefaultKeys.bluetoothDebug)
        
        BluetoothController.shared.sendingDelegate?.requestSettings()
        BluetoothController.shared.settingsDelegate = self
    }

	@IBAction func logWindowAction(_ sender: Any) {
        delegate.setAppLogging(enabled: logWindowSwitch.isOn)
	}
	
    @IBAction func bluetoothDebugAction(_ sender: Any) {
        defaults.set(bluetoothDebug.isOn, forKey: DefaultKeys.bluetoothDebug)
        MKUIToast.shared.showNotification(text: "This will probably crash", alignment: NSTextAlignment.center, color: .flatRed, identifier: nil) {
            BluetoothController.shared.bluetoothDebug = self.bluetoothDebug.isOn
        }
        
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
    
    deinit {
        BluetoothController.shared.settingsDelegate = nil
    }
	
	@IBAction func bugReportAction(_ sender: Any) {
        let sfView = SFSafariViewController(url: URL.init(string: "https://github.com/LJ-STAND/Apps/issues/new")!)
        
        delegate.window?.rootViewController?.present(sfView, animated: true, completion: nil)
	}
    
    @IBAction func fakeBluetoothData(_ sender: Any) {
        BluetoothController.shared.overrideConnect = true
        BluetoothController.shared.connected = true
        BluetoothController.shared.fakeData = true
        MKULog.shared.info("[BLUETOOTH] Fake Data Enabled")
        MKULog.shared.mark()
    }
}

extension SettingsTableViewController: BluetoothControllerSettingsDelegate {
    func updatedSettings(compass: Bool, light: Bool, tsop: Bool) {
        compassSwitch.isOn = compass
        lightSwitch.isOn = light
        tsopSwitch.isOn = tsop
    }
}
