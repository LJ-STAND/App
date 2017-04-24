//
//  AppDelegate+AppSettings.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 24/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

extension AppDelegate: AppSettingsDelegate {
    func setDockOnRight(right: Bool) {
        defaults.set(right, forKey: DefaultKeys.isDockOnRight)
        setFrames()
        orientationDidChange()
    }
    
    func setLogWindow(enabled: Bool) {
        defaults.set(enabled, forKey: DefaultKeys.showLog)
        (UIApplication.shared.delegate as! AppDelegate).appLogDelegate?.enableAppLogging(enabled: enabled)
    }
}
