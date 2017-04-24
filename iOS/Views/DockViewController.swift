//
//  DockViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 25/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class DockViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerHeight = CGFloat(120)
        let lineWidth = view.frame.width * 0.9
        let lineX = (view.frame.width - lineWidth) / 2
        
        var textWidth = CGFloat(0)
        var buttonSpacing = ((lineWidth) / 5) + 2
        var buttonWidth = lineWidth / 5
        var buttonStart = lineX + (textWidth * 1.2)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let titleView = CenteredTextView(frame: CGRect(x: lineX, y: 0.0, width: lineWidth, height: headerHeight))
            titleView.text = "LJ STAND"
            titleView.textSize = view.frame.height * 0.1
            titleView.horizontalAlignment = NSTextAlignment.left
            titleView.backgroundColor = UIColor.clear
            
            view.addSubview(titleView)
            
            textWidth = titleView.textWidth()
            
            buttonSpacing = (lineWidth - (textWidth * 1.2)) / 5
            buttonWidth = buttonSpacing * 0.7
            buttonStart = lineX + (textWidth * 1.2)
        }
        
        let serialButton = HexButton(frame: CGRect(x: buttonStart + buttonSpacing * 0 + (buttonSpacing - buttonWidth) / 2, y: 0, width: buttonWidth, height: view.frame.height * 0.15))
        serialButton.text = "SERIAL"
        serialButton.viewName = "Serial"
        serialButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        view.addSubview(serialButton)
        
        let tsopButton = HexButton(frame: CGRect(x: buttonStart + buttonSpacing * 1 + (buttonSpacing - buttonWidth) / 2, y: 0, width: buttonWidth, height: view.frame.height * 0.15))
        tsopButton.text = "TSOP"
        tsopButton.viewName = "TSOP"
        tsopButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        view.addSubview(tsopButton)
        
        let lightButton = HexButton(frame: CGRect(x: buttonStart + buttonSpacing * 2 + (buttonSpacing - buttonWidth) / 2, y: 0, width: buttonWidth, height: view.frame.height * 0.15))
        lightButton.text = "LIGHT"
        lightButton.viewName = "Light"
        lightButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        view.addSubview(lightButton)
        
        let compassButton = HexButton(frame: CGRect(x: buttonStart + buttonSpacing * 3 + (buttonSpacing - buttonWidth) / 2, y: 0, width: buttonWidth, height: view.frame.height * 0.15))
        compassButton.text = "COMPASS"
        compassButton.viewName = "Compass"
        compassButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        view.addSubview(compassButton)
        
        let settingsButton = HexButton(frame: CGRect(x: buttonStart + buttonSpacing * 4 + (buttonSpacing - buttonWidth) / 2, y: 0, width: buttonWidth, height: view.frame.height * 0.15))
        settingsButton.text = "SETTINGS"
        settingsButton.viewName = "Settings"
        settingsButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        view.addSubview(settingsButton)
        
        view.layoutIfNeeded()
        
        let frac = CGFloat(25)/255
        view.backgroundColor = UIColor(red: frac, green: frac, blue: frac, alpha: 1.0)
    }
    
    func buttonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWindow"), object: (sender as! HexButton).viewName)
    }
    
    func generateConstraints(superView: UIView, subView: UIView) {
        superView.addConstraints([NSLayoutConstraint.init(item: subView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: 0.0), NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: 0.0), NSLayoutConstraint.init(item: subView, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1.0, constant: 0.0), NSLayoutConstraint.init(item: subView, attribute: .right, relatedBy: .equal, toItem: superView, attribute: .right, multiplier: 1.0, constant: 0.0)])
    }
}
