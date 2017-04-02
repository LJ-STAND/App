//
//  AuthorizeBluetoothViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 3/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
import MKUtilityKit

class AuthorizeBluetoothViewController: UIViewController {
    var authorized = false
    
    override func viewDidLoad() {
        MKUAsync.background {
            while (self.authorized == false) {
                self.updateAuthorization()
            }
            }.main {
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.removeWindow(name: "Auth Bluetooth")
        }
    }
    
    func updateAuthorization() {
        var returnValue = false
        let bluetooth = MKUPermission.bluetooth
        
        let status = bluetooth.status
        
        if (status == .denied || status == .disabled || status == .notDetermined) {
            bluetooth.request({ (newStatus) in
                if newStatus == .authorized {
                    returnValue = true
                }
            })
        } else {
            returnValue = true
        }
        authorized = returnValue
    }
}
