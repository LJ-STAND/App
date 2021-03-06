//
//  AppDelegate+AppSettings.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 24/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
import MKUtilityKit

extension AppDelegate: AppSettingsDelegate {
    func setAppLogging(enabled: Bool) {
        defaults.set(enabled, forKey: DefaultKeys.showLog)
        setUpWindows()
    }
    
    var appLogEnabled: Bool {
        get {
            return defaults.bool(forKey: DefaultKeys.showLog)
        }
        
        set {
            defaults.set(newValue, forKey: DefaultKeys.showLog)
        }
    }
}
