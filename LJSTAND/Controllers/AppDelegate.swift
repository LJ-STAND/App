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

let ljStandGreen = UIColor.flatGreenDark

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var dock: UIWindow?
    let defaults = MKUDefaults(suiteName: MKAppGroups.LJSTAND).defaults
    var dockFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var windowFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    @nonobjc var windows: [WMWindow] = []
    var shortcutItem: UIApplicationShortcutItem?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        setUpWindows()
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.addWindow(notification:)), name: NSNotification.Name(rawValue: "addWindow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.orientationDidChange), name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
        
        var performShortcutDelegate = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            print("Application launched via shortcut")
            self.shortcutItem = shortcutItem
            
            performShortcutDelegate = false
        }
        
        application.setStatusBarStyle(.lightContent, animated: false)
        
        BluetoothController.shared.messageDelegate = self
        BluetoothController.shared.bluetoothDebug = false
        
        let bluetooth = MKUPermission.bluetooth
        let status = bluetooth.status
        
        if status == .denied || status == .disabled || status == .notDetermined {
            BluetoothController.shared.overrideConnect = true
        }
        
        if UIDevice.current.isSimulator == true {
            BluetoothController.shared.overrideConnect = true
        }

        return performShortcutDelegate
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
        
    }
    
    func addWindow(notification: NSNotification) {
        let viewName = notification.object as! String
        addWindow(viewName: viewName)
    }
    
    func setFrames() {
        let screenBounds = UIScreen.main.bounds
        let dockWidth = 100
        
        let isDockOnRight = defaults.bool(forKey: DefaultKeys.isDockOnRight)
        
        if isDockOnRight == true {
            windowFrame = CGRect(x: 0, y: 0, width: (Int(screenBounds.width) - dockWidth), height: Int(screenBounds.height))
            dockFrame = CGRect(x: (Int(screenBounds.width) - dockWidth), y: 0, width: dockWidth, height: Int(screenBounds.height))
        } else {
            dockFrame = CGRect(x: 0, y: 0, width: dockWidth, height: Int(screenBounds.height))
            windowFrame = CGRect(x: dockWidth, y: 0, width: (Int(screenBounds.width) - dockWidth), height: Int(screenBounds.height))
        }
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


extension AppDelegate: BluetoothMessageDelegate {
    func showInformation(_ message: String) {
        MKUIToast.shared.showNotification(text: message, alignment: .center, color: .flatBlue, identifier: nil, callback: {})
        MKULog.shared.info(message)
    }
    
    func showError(_ message: String) {
        MKUIToast.shared.showNotification(text: message, alignment: .center, color: .flatRed, identifier: nil, callback: {})
        MKULog.shared.error(message)
    }
    
    func foundDevices(_ peripherals: [CBPeripheral]) {
        let alert = UIAlertController(title: "Connect to Device", message: nil, preferredStyle: .alert)
        
        for item in peripherals {
            alert.addAction(UIAlertAction(title: item.name, style: .default, handler: { (action) in
                BluetoothController.shared.connectTo(item)
            }))
        }
        
        window?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    func dismissNotifications() {
        MKUIToast.shared.dismissAllNotifications(animated: false)
    }
}

extension AppDelegate: AppSettingsDelegate {
    func setDockOnRight(right: Bool) {
        defaults.set(right, forKey: DefaultKeys.isDockOnRight)
        setFrames()
        orientationDidChange()
    }
    
    func setLogWindow(enabled: Bool) {
        defaults.set(enabled, forKey: DefaultKeys.showLog)
        exit(0)
    }
}
