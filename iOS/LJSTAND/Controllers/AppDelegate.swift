//
//  AppDelegate.swift
//  Layers
//
//  Created by Lachlan Grant on 10/10/16
//  Copyright (c) 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import Chameleon

let log = MKLogController().log
let parts = PartParser()

//let ljStandGreen = UIColor(colorLiteralRed: 25, green: 142, blue: 44, alpha: 1.0)
let ljStandGreen = UIColor.flatGreenColorDark()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        UITabBar.appearance().tintColor = ljStandGreen
        
        log.logAppDetails()
        checkForUpdate()
        return true
    }
    
    func checkForUpdate() {
        if !MKAppSettingsController().isDebugBuild && MKReachability().connectedToNetwork() {
            do {
                let urlStr = "https://lj-stand.github.io/Apps/config.json"
                let url = URL(string: urlStr)
                
                let data = try Data(contentsOf: url!)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                
                let releasedVer = json["currentRelease"] as! Int
                
                let thisBuild = Int(MKAppSettingsController().build)!
                
                if releasedVer > thisBuild {
                    log.info("Update")
                    let url = URL(string: "itms-services://?action=download-manifest&url=https://lj-stand.github.io/Apps/dist/manifest.plist")!
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } catch {
                log.info("Unable to retrieve JSON data from server")
            }
        } else {
            log.info("No Internet Connection or Debug")
        }
    }
    
}
