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
    var viewManager: ViewManager?
    var shortcutItem: UIApplicationShortcutItem?
    var settingsDelegate: AppSettingsDelegate!
    var navController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        setUpFonts()
        setUpWindows()
        setUpNotifications()
        
        settingsDelegate = self
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        BluetoothController.shared.messageDelegate = self
        BluetoothController.shared.bluetoothDebug = false
        
        return true
    }
    
    func setUpFonts() {
        let fontURL = Bundle.main.url(forResource: "Dosis-Light", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
    }
    
    func setUpNotifications() {
        let selector = #selector(AppDelegate.orientationDidChange)
        let notifName = Notification.Name.UIDeviceOrientationDidChange
        NotificationCenter.default.addObserver(self, selector: selector, name: notifName, object: nil)
    }
    
    func setUpWindows() {
        let view = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: "background") as! BackgroundViewController
        
        viewManager = view
        
        navController = UINavigationController(rootViewController: view)
        navController?.navigationBar.barStyle = .blackTranslucent
        navController?.navigationBar.topItem?.title = "LJ STAND"
        
        if #available(iOS 11.0, *) {
            navController?.navigationBar.prefersLargeTitles = true
        }
        
        let sideMenuController = SlideMenuController(mainViewController: navController!, leftMenuViewController: MenuTableViewController())
        sideMenuController.view.backgroundColor = .black
        
        sideMenuController.delegate = self
        
        if appLogEnabled {
            let consoleManager = MKUConsoleManager.shared.getWindow(withRootViewController: sideMenuController, withBounds: UIScreen.main.bounds)
            window = consoleManager
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = sideMenuController
        }
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
    
    @objc func orientationDidChange() {
        window?.frame = UIScreen.main.bounds
        window?.layoutIfNeeded()
    }
    
    func changeNavBarTitle(_ object: String) {
        if object != "" {
            navController?.navigationBar.topItem?.title = "LJ STAND - \(object)"
        } else {
            navController?.navigationBar.topItem?.title = "LJ STAND"
        }
    }

}
