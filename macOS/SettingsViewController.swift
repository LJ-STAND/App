//
//  SettingsViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 6/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {
    @IBOutlet weak var tsopDebug: NSButton!
    @IBOutlet weak var lightDebug: NSButton!
    @IBOutlet weak var compassDebug: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BluetoothController.shared.sendingDelegate?.requestSettings()
        BluetoothController.shared.settingsDelegate = self
    }
    
    @IBAction func tsopAction(_ sender: Any) {
        sendUpdatedSettings()
    }
    
    @IBAction func lightAction(_ sender: Any) {
        sendUpdatedSettings()
    }
    
    @IBAction func compassAction(_ sender: Any) {
        sendUpdatedSettings()
    }
    
    func sendUpdatedSettings() {
        BluetoothController.shared.sendingDelegate?.sendSettings(compass: intToBool(intValue: compassDebug.state), tsop: intToBool(intValue: tsopDebug.state), light: intToBool(intValue: lightDebug.state))
    }
    
    fileprivate func intToBool(intValue: Int) -> Bool {
        if intValue == 0 {
            return false
        } else {
            return true
        }
    }
    
    fileprivate func boolToInt(boolValue: Bool) -> Int {
        if boolValue == true {
            return 1
        } else {
            return 0
        }
    }
}

extension SettingsViewController: BluetoothControllerSettingsDelegate {
    func updatedSettings(compass: Bool, light: Bool, tsop: Bool) {
        tsopDebug.state = tsop.hashValue
        lightDebug.state = light.hashValue
        compassDebug.state = compass.hashValue
    }
}
