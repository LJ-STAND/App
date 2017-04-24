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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var dock: UIWindow?
    
    var dockFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
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
        
        dock = UIWindow(frame: dockFrame)
        dock?.windowLevel = 3
        dock?.rootViewController = viewController(fromStoryboardWithName: "Dock", viewControllerWithIdentifier: "init")
        dock?.isHidden = false
        dock?.backgroundColor = .clear
        
        let view = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: "background")
        window = UIWindow(frame: windowFrame)
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.windowLevel = 1
        
        swizzleUIWindow()
        
        UITabBar.appearance().tintColor = ljStandGreen
        
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
    }
    
    func addWindow(notification: NSNotification) {
        let viewName = notification.object as! String
        addWindow(viewName: viewName)
    }
    
    func setFrames() {
        let screenBounds = UIScreen.main.bounds
        
        let dockHeight = 120.0

        dockFrame = CGRect(x: 0.0, y: 0.0, width: Double(screenBounds.width), height: dockHeight)
        windowFrame = CGRect(x: 0.0, y: dockHeight, width: Double(screenBounds.width), height: Double(screenBounds.height) - dockHeight)
    }
    
    func orientationDidChange() {
        dock?.frame = dockFrame
        window?.frame = windowFrame
        
        dock?.layoutIfNeeded()
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
                newWindow.setFrame(frame: CGRectMake(-kWindowResizeGutterSize, -kWindowResizeGutterSize, (window?.bounds.size.width)!+(kWindowResizeGutterSize*2), (window?.bounds.size.height)!+(kWindowResizeGutterSize*2)))
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
