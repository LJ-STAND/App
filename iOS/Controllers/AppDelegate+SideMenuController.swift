//
//  AppDelegate+SideMenuController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 11/5/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
import MKUIKit

extension AppDelegate: SlideMenuControllerDelegate {
    func leftDidOpen() {
        MKUITapticEngine.impact.feedback(.heavy)
    }
    
    func leftDidClose() {
        MKUITapticEngine.impact.feedback(.heavy)
    }
}
