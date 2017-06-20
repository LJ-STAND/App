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

extension UIViewController {
    func generateConstraints(subView: UIView, topPadding: Double = 0) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: CGFloat(topPadding))
        let right = NSLayoutConstraint(item: subView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0)
        let left = NSLayoutConstraint(item: subView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([top, right, left, bottom])
        self.view.layoutIfNeeded()
    }
    
    func generateContraints(subView: UIView, padding: Double = 0) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingFloat = CGFloat(padding)
        
        let top = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: paddingFloat)
        let right = NSLayoutConstraint(item: subView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: paddingFloat)
        let left = NSLayoutConstraint(item: subView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: paddingFloat)
        let bottom = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: paddingFloat)
        
        self.view.addConstraints([top, right, left, bottom])
        self.view.layoutIfNeeded()
    }
}
