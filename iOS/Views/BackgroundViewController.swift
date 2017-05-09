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
    var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = UIView(frame: self.view.bounds)
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        generateConstraints(superView: view, subView: container, topPadding: 94.0)
        
        view.layoutIfNeeded()
        
        self.slideMenuController()?.addLeftGestures()
        self.addLeftBarButtonWithImage(UIImage(named: "hamB")!)
        checkShoudShowLogView()
    }
    
    func checkShoudShowLogView() {
        if defaults.bool(forKey: DefaultKeys.showLog) == true {
            showAppLog()
        }
        
        (UIApplication.shared.delegate as! AppDelegate).appLogDelegate = self
    }
    
    func generateConstraints(superView: UIView, subView: UIView, topPadding: Double = 0) {
        superView.addConstraints([NSLayoutConstraint.init(item: subView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: CGFloat(topPadding)), NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: 0.0), NSLayoutConstraint.init(item: subView, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1.0, constant: 0.0), NSLayoutConstraint.init(item: subView, attribute: .right, relatedBy: .equal, toItem: superView, attribute: .right, multiplier: 1.0, constant: 0.0)])
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


extension BackgroundViewController: ViewManager {
    func changeView(_ viewName: String) {
        let newVC = viewController(fromStoryboardWithName: "Main", viewControllerWithIdentifier: viewName)
        guard let newView = newVC.view else {
            return
        }
        
        newView.bounds = container.bounds
        newView.backgroundColor = .clear
        
        for subview in newView.subviews {
            subview.backgroundColor = .clear
        }
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(newView)
        
        generateConstraints(superView: container, subView: newView)
        
        newView.layoutIfNeeded()
        container.layoutIfNeeded()

    }
    
    func clearView() {
        for subview in container.subviews {
            subview.removeFromSuperview()
        }
    }
}
