//
//  AppDelegate+3DTouch.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 24/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

struct ShortcutIDS {
    static let base = "com.lachlangrant.LJSTAND"
    static let tsop = base + ".tsop"
    static let light = base + ".light"
    static let compass = base + ".compass"
    static let settings = base + ".settings"
}

extension AppDelegate {
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("Application performActionForShortcutItem")
        completionHandler( handleShortcut(shortcutItem: shortcutItem) )
    }
    
    func performShortcutDelegate(launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        var performShortcutDelegate = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            print("Application launched via shortcut")
            self.shortcutItem = shortcutItem
            
            performShortcutDelegate = false
        }
        
        return performShortcutDelegate
    }
    
    func handleShortcut( shortcutItem:UIApplicationShortcutItem ) -> Bool {
        var succeeded = false
        var view = ""
        switch shortcutItem.type {
        case ShortcutIDS.tsop:
            view = "TSOP"
        case ShortcutIDS.compass:
            view = "Compass"
        case ShortcutIDS.light:
            view = "Light"
        case ShortcutIDS.settings:
            view = "Settings"
        default:
            view = ""
        }
        
        if (view != "") {
            addWindow(viewName: view)
            succeeded = true
        }
        
        return succeeded
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        guard let shortcut = shortcutItem else { return }
        handleShortcut(shortcutItem: shortcut)
        self.shortcutItem = nil
        
    }
}
