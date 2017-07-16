//
//  AppDelegate+SplitScreen.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 16/7/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

extension AppDelegate {
    func applicationWillResignActive(_ application: UIApplication) {
        // User has moved multitasking divider
        NotificationCenter.default.post(Notification(name: NotificationKeys.resizedWindow))
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // User has moved divider all the way off screen
        
    }
}
