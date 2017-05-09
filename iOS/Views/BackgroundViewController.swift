//
//  BackgroundViewController.swift
//  LJ STAND
//
//  Created by James Yelland on 6/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
import MKUIKit
import MKUtilityKit
import MKKit

class BackgroundViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slideMenuController()?.addLeftGestures()
//        self.slideMenuController()?.addLeftBarButtonWithImage(UIImage(named: "hamB")!)
        
        self.addLeftBarButtonWithImage(UIImage(named: "hamB")!)
        checkShoudShowLogView()
    }
    
    func checkShoudShowLogView() {
        if defaults.bool(forKey: DefaultKeys.showLog) == true {
            showAppLog()
        }
        
        (UIApplication.shared.delegate as! AppDelegate).appLogDelegate = self
    }
    
    func generateConstraints(superView: UIView, subView: UIView) {
        superView.addConstraints([NSLayoutConstraint.init(item: subView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: 0.0), NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: 0.0), NSLayoutConstraint.init(item: subView, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1.0, constant: 0.0), NSLayoutConstraint.init(item: subView, attribute: .right, relatedBy: .equal, toItem: superView, attribute: .right, multiplier: 1.0, constant: 0.0)])
    }
    
    func showAppLog() {
        let logView = MKUConsoleViewController().view!
        
        logView.frame = view.frame
        logView.tag = 999
        view.addSubview(logView)
        logView.translatesAutoresizingMaskIntoConstraints = false
        
        generateConstraints(superView: view, subView: logView)
        
        for subview in logView.subviews {
            subview.backgroundColor = .clear
        }
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = view.frame
        blurView.tag = 999
        view.addSubview(blurView)
        
        view.sendSubview(toBack: blurView)
        view.sendSubview(toBack: imageView)
        view.layoutIfNeeded()
    }
    
    func removeAppLog() {
        for item in self.view.subviews {
            if item.tag == 999 {
                item.removeFromSuperview()
            }
        }
    }
}


extension BackgroundViewController: AppLogDelegate {
    func enableAppLogging(enabled: Bool) {
        if enabled == true {
            showAppLog()
        } else {
            removeAppLog()
        }
    }
}
