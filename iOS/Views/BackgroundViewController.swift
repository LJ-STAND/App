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
    var blurEffect: UIBlurEffect {
        get {
            return UIBlurEffect(style: .dark)
        }
    }
    var blurView: UIVisualEffectView {
        get {
            let tempView = UIVisualEffectView(effect: blurEffect)
            tempView.frame = view.frame
            tempView.tag = 999
            
            return tempView
        }
    }
    var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blurView)
        
        view.sendSubview(toBack: blurView)
        view.sendSubview(toBack: imageView)
        
        container = UIView(frame: self.view.bounds)
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        
        //TODO: Fix
        self.generateConstraints(superView: view, subView: container, topPadding: 104.0)
        
        view.layoutIfNeeded()
        
        self.slideMenuController()?.addLeftGestures()
        self.addLeftBarButtonWithImage(UIImage(named: "hamB")!)
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
