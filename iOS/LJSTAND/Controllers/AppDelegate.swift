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

let log = MKULog.shared

let ljStandGreen = UIColor.flatGreenDark

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var dock: UIWindow?
    @nonobjc var windows: [WMWindow] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let screenBounds = UIScreen.main.bounds
        let dockWidth = 100
        let dockFrame = CGRect(x: 0, y: 0, width: dockWidth, height: Int(screenBounds.height))
        let windowFrame = CGRect(x: dockWidth, y: 0, width: (Int(screenBounds.width) - dockWidth), height: Int(screenBounds.height))
        
        dock = UIWindow(frame: dockFrame)
        dock?.windowLevel = 3
        dock?.rootViewController = viewController(fromStoryboardWithName: "Dock", viewControllerWithIdentifier: "init")
        dock?.makeKeyAndVisible()
        dock?.backgroundColor = .clear
        
        let view = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: "background")
        window = UIWindow(frame: windowFrame)
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.windowLevel = 1
        
        let defaults = MKUDefaults(suiteName: MKAppGroups.LJSTAND).defaults
        
        swizzleUIWindow()
        
        UITabBar.appearance().tintColor = ljStandGreen
        application.setStatusBarStyle(.lightContent, animated: false)
        
        if defaults.bool(forKey: DefaultKeys.showLog) == true {
            logWindow()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.addWindow(notification:)), name: NSNotification.Name(rawValue: "addWindow"), object: nil)
        
        return true
    }
    
    func addWindow(notification: NSNotification) {
        let viewName = notification.object as! String
        addWindow(viewName: viewName)
    }
    
    func addWindow(viewName: String) {
        var isShown = false
        var hiddenWindow: WMWindow!
        for item in windows {
            if item.title == viewName {
                isShown = true
                hiddenWindow = item
            }
        }
        
        if !isShown {
            let newWindow = WMWindow(frame: CGRectMake(44, 344, 300, 300))
            newWindow.title = viewName
            newWindow.windowLevel = 1
            
            let mainView = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: viewName)
            mainView.title = viewName
            
            newWindow.rootViewController = mainView
            newWindow.makeKeyAndVisible()
            
            windows.append(newWindow)
            
            window?.addSubview(newWindow)
        } else {
            hiddenWindow.makeKeyAndVisible()
        }
    }
    
    func initialWindow() {
        let window1 = WMWindow(frame: CGRectMake(44, 44, 300, 300))
        window1.title = "Root"
        
        let mainView = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: "windowMain")
        mainView.title = "Root"
        
        window1.rootViewController = mainView
        window1.makeKeyAndVisible()
        window1.disableClose()
        
        windows.append(window1)
        window?.addSubview(window1)
    }
    
    func logWindow() {
        MKUIToast.shared.showNotification(text: "Testing", alignment: .center, color: .flatBlue, identifier: nil, callback: {})
        let viewName = "App Log"
        
        var isShown = false
        var hiddenWindow: WMWindow!
        for item in windows {
            if item.title == viewName {
                isShown = true
                hiddenWindow = item
            }
        }
        
        if !isShown {
            let newWindow = WMWindow(frame: CGRectMake(44, 344, 300, 300))
            newWindow.title = viewName
            
            let mainView = MKUConsoleViewController()
            let nav = UINavigationController(rootViewController: mainView)
            nav.title = viewName
            mainView.title = viewName
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.barStyle = .black
            
            newWindow.rootViewController = nav
            newWindow.makeKeyAndVisible()
            
            windows.append(newWindow)
            
            window?.addSubview(newWindow)
        } else {
            hiddenWindow.makeKeyAndVisible()
        }
    }
    
    func removeWindow(name: String) {
        print(name)
        for item in windows {
            if item.title == name {
                item.close(self)
            }
        }
    }
}

