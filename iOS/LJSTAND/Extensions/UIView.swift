//
//  UIView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 14/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit

extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}
