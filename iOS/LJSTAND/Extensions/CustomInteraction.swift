//
//  CustomInteraction.swift
//  LJ STAND
//
//  Created by James Yelland on 29/1/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit
import MKUIKit
import MKUtilityKit

class CustomInteraction: UIPercentDrivenInteractiveTransition {
    var navigationController: UINavigationController?
    var shouldCompleteTransition = false
    var transitionInProgress = false
    
    override init() {
        super.init()
        
        completionSpeed = 1 - percentComplete
    }
    
    func attachToViewController(_ viewController: UIViewController) {
        navigationController = viewController.navigationController
        setupGestureRecognizer(view: viewController.view)
    }
    
    private func setupGestureRecognizer(view: UIView) {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(CustomInteraction.handlePanGesture(gestureRecognizer:))))
    }
    
    func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        guard let gestureSuperview = gestureRecognizer.view?.superview else {
            return
        }
        
        MKUIToast.shared.dismissAllNotifications(animated: false)
        
        let viewTranslation = gestureRecognizer.translation(in: gestureSuperview)
        let location = gestureRecognizer.location(in: gestureSuperview)
        
        switch gestureRecognizer.state {
        case .began:
            if location.x > PercentageValues.Threshold.rawValue {
                cancel()
                return
            }
            
            transitionInProgress = true
            navigationController?.popViewController(animated: true)
            
        case .changed:
            let const = CGFloat(fminf(fmaxf(Float(viewTranslation.x / 200.0), 0.0), 1.0))
            shouldCompleteTransition = const > PercentageValues.Half.rawValue
            update(const)
        
        case .cancelled, .ended:
            transitionInProgress = false
            
            if !shouldCompleteTransition || gestureRecognizer.state == .cancelled {
                cancel()
            } else {
                finish()
            }
    
        default: break
        }
    }
}

enum PercentageValues: CGFloat {
    case Threshold = 50.0
    case Half = 0.50
}
