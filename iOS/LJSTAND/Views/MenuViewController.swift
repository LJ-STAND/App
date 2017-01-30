//
//  MenuViewController.swift
//  LJ STAND
//
//  Created by James Yelland on 29/1/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, AnimationViewController, UINavigationControllerDelegate {
    internal var tappedButton: UIButton?
    
    let presenting = CustomPresentation()
    let interaction = CustomInteraction()
    
    var serialButton: HexButtonView!
    var TSOPButton: HexButtonView!
    var lightButton: HexButtonView!
    var compassButton: HexButtonView!
    var designButton: HexButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        
        let hexagonWidth = self.view.frame.width / 3
        let topBottomPadding = (self.view.frame.height - hexagonWidth * 3) / 2
        let differenceHeight = hexagonWidth * CGFloat(sin(M_PI/6))
        let differenceWidth = hexagonWidth * CGFloat(cos(M_PI/6))
        
        self.navigationController?.delegate = self
        self.view.backgroundColor = UIColor(colorLiteralRed: 48/255, green: 48/255, blue: 48/255, alpha: 1.0)
        
        serialButton = HexButtonView(frame: CGRect(x: self.view.frame.midX - differenceWidth / 2 - hexagonWidth / 2, y: topBottomPadding, width: hexagonWidth, height: hexagonWidth))
        serialButton.text = "Serial"
        serialButton.addTarget(self, action: #selector(MenuViewController.serialButton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(serialButton)
        
        TSOPButton = HexButtonView(frame: CGRect(x: self.view.frame.midX + differenceWidth / 2 - hexagonWidth / 2, y: serialButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth))
        TSOPButton.text = "TSOP"
        TSOPButton.addTarget(self, action: #selector(MenuViewController.TSOPButton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(TSOPButton)
        
        lightButton = HexButtonView(frame: CGRect(x: self.view.frame.midX - differenceWidth / 2 - hexagonWidth / 2, y: TSOPButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth))
        lightButton.text = "Light"
        lightButton.addTarget(self, action: #selector(MenuViewController.lightButton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(lightButton)
        
        compassButton = HexButtonView(frame: CGRect(x: self.view.frame.midX + differenceWidth / 2 - hexagonWidth / 2, y: lightButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth))
        compassButton.text = "Compass"
        compassButton.addTarget(self, action: #selector(MenuViewController.compassButton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(compassButton)
        
        designButton = HexButtonView(frame: CGRect(x: self.view.frame.midX - differenceWidth / 2 - hexagonWidth / 2, y: compassButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth))
        designButton.text = "Design"
        designButton.addTarget(self, action: #selector(MenuViewController.designButton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(designButton)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func serialButton(sender: UIButton) {
        self.tappedButton = sender
        self.navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Serial"), animated: true)
    }
    
    func TSOPButton(sender: UIButton) {
        self.tappedButton = sender
        self.navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TSOP"), animated: true)
    }
    
    func lightButton(sender: UIButton) {
        self.tappedButton = sender
        self.navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Light"), animated: true)
    }
    
    func compassButton(sender: UIButton) {
        self.tappedButton = sender
        self.navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Compass"), animated: true)
    }
    
    func designButton(sender: UIButton) {
        self.tappedButton = sender
        self.navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Design"), animated: true)
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            interaction.attachToViewController(toVC)
        }
        
        presenting.reverse = operation == .pop
        return presenting
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interaction.transitionInProgress ? interaction : nil
    }
}
