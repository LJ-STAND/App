//
//  AppDelegate.swift
//  Layers
//
//  Created by Lachlan Grant on 10/10/16
//  Copyright (c) 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit

let log = MKLogController().log


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        log.logAppDetails()
        return true
    }
}
//let MessageOptionKey = "MessageOption"
//let ReceivedMessageOptionKey = "ReceivedMessageOption"
//let WriteWithResponseKey = "WriteWithResponse"
//
//
//
//UserDefaults.standard.register(defaults: [MessageOptionKey: MessageOption.noLineEnding.rawValue,
//                                          ReceivedMessageOptionKey: ReceivedMessageOption.none.rawValue,
//                                          WriteWithResponseKey: false
//    ])
