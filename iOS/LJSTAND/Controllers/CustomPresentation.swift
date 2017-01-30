//
//  CustomPresentation.swift
//  LJ STAND
//
//  Created by James Yelland on 29/1/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class CustomPresentation: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    private var portholeSize = CGSize(width: 10, height: 10)
    private var screenSize = UIScreen.main.bounds.size
    private let scale = UIScreen.main.scale
    private let identity = CATransform3DIdentity
    var transitionContext: UIViewControllerContextTransitioning?
    
    var reverse: Bool = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        var button: UIButton!
        
        if var fromAnimationViewController = fromViewController as? AnimationViewController {
            button = fromAnimationViewController.tappedButton!
        }
        
        if var toAnimationViewController = toViewController as? AnimationViewController {
            toAnimationViewController.tappedButton = button
        }
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        
        toViewController.view.clipsToBounds = false
        fromViewController.view.clipsToBounds = false
        toViewController.view.layer.masksToBounds = false
        fromViewController.view.layer.masksToBounds = false
        
        let extremePoint = CGPoint(x: button.center.x - 0, y: button.center.y - (toViewController.view.bounds.height * 1.5))
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        
        var hexMaskPathInitial: UIBezierPath
        var hexMaskPathFinal: UIBezierPath
        
        if reverse {
            hexMaskPathInitial = UIBezierPath(rect: toViewController.view.frame)
            hexMaskPathInitial.append(UIBezierPath.polygonIn(rect: button.frame.insetBy(dx: -radius, dy: -radius), numberOfSides: 6, rotationOffset: 0))
            hexMaskPathInitial.usesEvenOddFillRule = true
            hexMaskPathInitial.addClip()
            
            hexMaskPathFinal = UIBezierPath(rect: toViewController.view.frame)
            hexMaskPathFinal.append(UIBezierPath.polygonIn(rect: button.frame, numberOfSides: 6, rotationOffset: 0))
            hexMaskPathFinal.usesEvenOddFillRule = true
            hexMaskPathFinal.addClip()
        } else {
            hexMaskPathInitial = UIBezierPath.polygonIn(rect: button.frame, numberOfSides: 6, rotationOffset: 0)
            hexMaskPathFinal = UIBezierPath.polygonIn(rect: button.frame.insetBy(dx: -radius, dy: -radius), numberOfSides: 6, rotationOffset: 0)
        }

        let maskLayer = CAShapeLayer()
        maskLayer.path = hexMaskPathInitial.cgPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        toViewController.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = hexMaskPathInitial.cgPath
        maskLayerAnimation.toValue = hexMaskPathFinal.cgPath
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        maskLayerAnimation.isRemovedOnCompletion = false
        maskLayerAnimation.fillMode = kCAFillModeBoth
        maskLayerAnimation.duration = transitionDuration(using: transitionContext)
        maskLayerAnimation.delegate = self
        
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
        self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.layer.mask = nil
        self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
        
        self.transitionContext = nil
    }
}
