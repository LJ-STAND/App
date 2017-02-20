//
//  UIDevice+Simulator.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 5/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

extension UIDevice {
    var isSimulator: Bool {
        get {
            #if (arch(i386) || arch(x86_64))
                return true
            #endif
            
            return false

        }
    }
}
