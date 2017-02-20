//
//  AppDelegate.swift
//  Layers
//
//  Created by Lachlan Grant on 10/10/16
//  Copyright (c) 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import MKUtilityKit
import Chameleon

let log = MKULog.shared

let ljStandGreen = UIColor.flatGreenDark

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var windows: [WMWindow] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let view = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: "background")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        swizzleUIWindow()
        
        UITabBar.appearance().tintColor = ljStandGreen
        application.setStatusBarStyle(.lightContent, animated: false)
        
        logWindow()
        initialWindow()
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.addWindow(notification:)), name: NSNotification.Name(rawValue: "addWindow"), object: nil)
        return true
    }
    
    func addWindow(notification: NSNotification) {
        let viewName = notification.object as! String
        
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
        let logWindow = WMWindow(frame: CGRectMake(44, 344, 400, 300))
        logWindow.title = "App Log"
        
        let view = MKUConsoleViewController()
        
        view.title = "App Log"
        
        let nav = UINavigationController(rootViewController: view)
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.barStyle = .black
        logWindow.rootViewController = nav
        logWindow.makeKeyAndVisible()
        window?.addSubview(logWindow)
        
        checkForUpdate()
    }
    
    func checkForUpdate() {
        MKUAsync.background {
            MKULog.shared.info("Checking for update")
            MKUAppSettings.shared.checkForAppUpdate(urlString: "https://lj-stand.github.io/Apps/config.json", jsonKey: "currentRelease", manifestURL: "https://lj-stand.github.io/Apps/dist/manifest.plist", messageCallback: { (error, message) in
                if error {
                    MKULog.shared.error(message)
                } else {
                    MKULog.shared.info(message)
                }
            }) { (url, message) in
                MKULog.shared.info(message)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            MKULog.shared.mark()
        }
    }
}

