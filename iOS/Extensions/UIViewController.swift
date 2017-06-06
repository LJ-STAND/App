//
//  UIViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 27/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit

extension UIViewController {
    func tintNavigationController() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.flatBlack]
        self.navigationController?.navigationBar.tintColor = ljStandGreen
    }
}
