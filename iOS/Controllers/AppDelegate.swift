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
    var windowFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var appLogDelegate: AppLogDelegate?
    @nonobjc var windows: [WMWindow] = []
    
    var shortcutItem: UIApplicationShortcutItem?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        setUpFonts()
        setUpWindows()
        handleBluetoothStatus()
        setUpNotifications()
        
        application.setStatusBarStyle(.lightContent, animated: false)
        
        return performShortcutDelegate(launchOptions: launchOptions)
    }
    
    func setUpFonts() {
        let fontURL = Bundle.main.url(forResource: "Dosis-Light", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
    }
    
    func setUpNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.addWindow(notification:)), name: NSNotification.Name(rawValue: "addWindow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.orientationDidChange), name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func setUpWindows() {
        setFrames()
        let view = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: "background")
        
        let nav = UINavigationController(rootViewController: view)
        nav.navigationBar.barStyle = .blackTranslucent
        nav.navigationBar.topItem?.title = "LJ STAND"
        nav.navigationBar.topItem?.prompt = "Build: \(appSettings.build) - \(appSettings.pID)"
        nav.setStatusBarStyle(.lightContent)
        window = UIWindow(frame: windowFrame)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.windowLevel = 1
        
        swizzleUIWindow()
    }
    
    func addWindow(notification: NSNotification) {
        let viewName = notification.object as! String
        addWindow(viewName: viewName)
    }
    
    func setFrames() {
        let screenBounds = UIScreen.main.bounds

        windowFrame = CGRect(x: 0.0, y: 0.0, width: Double(screenBounds.width), height: Double(screenBounds.height))
    }
    
    func orientationDidChange() {
        window?.frame = windowFrame
        window?.layoutIfNeeded()
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
            mainView = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: viewName)
            mainView?.title = viewName
            
            newWindow.rootViewController = mainView
            newWindow.makeKeyAndVisible()
            
            windows.append(newWindow)
            
            window?.addSubview(newWindow)
            
            if (UIDevice.current.userInterfaceIdiom == .phone) {
                newWindow.maximized = true
                newWindow._savedFrame = CGRect(x: 44, y: 44, width: 300, height: 300)
                newWindow.setFrame(frame: CGRectMake(-kWindowResizeGutterSize, -kWindowResizeGutterSize + 95, (window?.bounds.size.width)!+(kWindowResizeGutterSize*2), (window?.bounds.size.height)!+(kWindowResizeGutterSize*2) - 95))
            }
            
        } else {
            hiddenWindow.makeKeyAndVisible()
        }
        
        NotificationCenter.default.post(name: NotificationKeys.addedWindow, object: viewName)
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
        for item in windows {
            if item.title == name {
                item.close(self)
            }
        }
    }
}
