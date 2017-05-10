//
//  AppDelegate.swift
//  Layers
//
//  Created by Lachlan Grant on 10/10/16
//  Copyright (c) 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import MKUIKit
import MKUtilityKit
import Chameleon
import CoreBluetooth

//Globals
let ljStandGreen = UIColor.flatGreenDark
let defaults = MKUDefaults(suiteName: MKAppGroups.LJSTAND).defaults
let appSettings = MKUAppSettings()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appLogDelegate: AppLogDelegate?
    var viewManager: ViewManager?
    var shortcutItem: UIApplicationShortcutItem?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        setUpFonts()
        setUpWindows()
        handleBluetoothStatus()
        setUpNotifications()
        
        
        
        return performShortcutDelegate(launchOptions: launchOptions)
    }
    
    func setUpFonts() {
        let fontURL = Bundle.main.url(forResource: "Dosis-Light", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
    }
    
    func setUpNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.orientationDidChange), name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func setUpWindows() {
        let view = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: "background") as! BackgroundViewController
        
        viewManager = view
        
        let nav = UINavigationController(rootViewController: view)
        nav.navigationBar.barStyle = .blackTranslucent
        nav.navigationBar.topItem?.title = "LJ STAND"
        nav.navigationBar.topItem?.prompt = "Build: \(appSettings.build) - \(appSettings.pID)"
        nav.setStatusBarStyle(.lightContent)
        
        let sideMenuController = SlideMenuController(mainViewController: nav, leftMenuViewController: MenuTableViewController())
        sideMenuController.view.backgroundColor = .black
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = sideMenuController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.windowLevel = UIWindowLevelAlert
    }
    
    func orientationDidChange() {
        window?.frame = UIScreen.main.bounds
        window?.layoutIfNeeded()
    }

}
