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
    var blurView: UIVisualEffectView!
    var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.frame
        blurView.tag = 999
        
        view.addSubview(blurView)
        
        view.sendSubview(toBack: blurView)
        view.sendSubview(toBack: imageView)
        
        container = UIView(frame: self.view.bounds)
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        self.generateContraints(subView: container)
        self.generateContraints(subView: imageView)
        self.generateContraints(subView: blurView)
        
        view.layoutIfNeeded()
        
        self.slideMenuController()?.addLeftGestures()
        self.addLeftBarButtonWithImage(UIImage(named: "hamB")!)
        
        imageView.contentMode = .center
        imageView.contentMode = .scaleAspectFill
        
        NotificationCenter.default.addObserver(self, selector: #selector(BackgroundViewController.redrawViews), name: NotificationKeys.resizedWindow, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let views = [imageView, container/*, blurView*/]
        
        for item in views {
            item!.removeConstraints(item!.constraints)
        }
        
        for item in views {
            self.generateContraints(subView: item!)
        }
    }
    
    @objc func redrawViews() {
//        container.layoutSubviews()
        for item in container.subviews {
            item.layoutSubviews()
            item.layoutIfNeeded()
        }
    }
}

extension BackgroundViewController: ViewManager {
    func changeView(_ viewName: String) {
        let newVC = mainStoryboard.getViewController(viewName)
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
        
        generateConstraints(subView: newView)
        
        newView.layoutIfNeeded()
        container.layoutIfNeeded()
    }
    
    func clearView() {
        for subview in container.subviews {
            subview.removeFromSuperview()
        }
    }
}
