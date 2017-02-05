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

let ljStandGreen = UIColor.flatGreenColorDark()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        let view = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: "background")
        let logVC = MKUConsoleManager.shared.getWindow(withRootViewController: view, withBounds: UIScreen.main.bounds)
        window = logVC
        window?.makeKeyAndVisible()
        window?.backgroundColor = .gray
        
        swizzleUIWindow()
        
        UITabBar.appearance().tintColor = ljStandGreen
        
        initialWindow()
        backgroundLaunch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.addWindow(notification:)), name: NSNotification.Name(rawValue: "addWindow"), object: nil)
        
        return true
    }
    
    func backgroundLaunch() {
        MKUAsync.background {
            log.logAppDetails()
            self.checkForUpdate()
        }
    }
    
    func addWindow(notification: NSNotification) {
//        print(notification.object)
        let viewName = notification.object as! String
        
        let newWindow = WMWindow(frame: CGRectMake(44, 344, 300, 300))
        newWindow.title = viewName
        
        let mainView = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: viewName)
        mainView.title = viewName
        
        newWindow.rootViewController = mainView
        newWindow.makeKeyAndVisible()
    
        window?.addSubview(newWindow)
    }
    
    func initialWindow() {
                let window1 = WMWindow(frame: CGRectMake(44, 44, 300, 300))
                window1.title = "Root"
        
                let mainView = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: "windowMain")
                mainView.title = "Root"
        
                window1.rootViewController = mainView
                window1.makeKeyAndVisible()
                window1.windowButtons?.first?.isUserInteractionEnabled = false
                
                window?.addSubview(window1)
    }
    
    func checkForUpdate() {
        if MKUReachability().isConnectedToNetwork /*&& MKUAppSettings.shared.isDebugBuild != true*/ {
            do {
                let urlStr = "https://lj-stand.github.io/Apps/config.json"
                let url = URL(string: urlStr)
                
                let data = try Data(contentsOf: url!)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                
                let releasedVer = json["currentRelease"] as! Int
                
                let thisBuild = Int(MKUAppSettings.shared.build)!
                
                if releasedVer > thisBuild {
                    log.info("Update")
                    let url = URL(string: "itms-services://?action=download-manifest&url=https://lj-stand.github.io/Apps/dist/manifest.plist")!
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    log.info("Latest or Development Version of App")
                }
            } catch {
                log.info("Unable to retrieve JSON data from server")
            }
        } else {
            log.info("No Internet Connection or Debug")
        }
    }
}

