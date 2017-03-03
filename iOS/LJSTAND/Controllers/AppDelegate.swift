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
    var shortcutItem: UIApplicationShortcutItem?
    
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
            addWindow(viewName: "App Log")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.addWindow(notification:)), name: NSNotification.Name(rawValue: "addWindow"), object: nil)
        
        var performShortcutDelegate = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            print("Application launched via shortcut")
            self.shortcutItem = shortcutItem
            
            performShortcutDelegate = false
        }
        
        return performShortcutDelegate
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
            
            var mainView: UIViewController?
            
            if viewName == "App Log" {
                let logVc = MKUConsoleViewController()
                
                mainView = UINavigationController(rootViewController: logVc)
                mainView?.title = viewName
                logVc.title = viewName
                (mainView as! UINavigationController).navigationBar.isTranslucent = false
                (mainView as! UINavigationController).navigationBar.barStyle = .black
            } else {
                mainView = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: viewName)
                mainView?.title = viewName
            }
            
            newWindow.rootViewController = mainView
            newWindow.makeKeyAndVisible()
            
            windows.append(newWindow)
            
            window?.addSubview(newWindow)
            
            if (UIDevice.current.userInterfaceIdiom == .phone) {
                newWindow.maximized = true
                newWindow._savedFrame = CGRect(x: 44, y: 44, width: 300, height: 300)
                newWindow.setFrame(frame: CGRectMake(-kWindowResizeGutterSize, kStatusBarHeight + -kWindowResizeGutterSize, (window?.bounds.size.width)!+(kWindowResizeGutterSize*2), (window?.bounds.size.height)!-kStatusBarHeight+(kWindowResizeGutterSize*2)))
            }
            
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
    
    func removeWindow(name: String) {
        print(name)
        for item in windows {
            if item.title == name {
                item.close(self)
            }
        }
    }
}

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
