//
//  WindowManagerViewController.swift
//  LJ STAND
//
//  Created by James Yelland on 5/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class WindowManagerViewController: UIViewController, ResizableViewController {
    var serialButton: HexButton!
    var TSOPButton: HexButton!
    var lightButton: HexButton!
    var compassButton: HexButton!
    var designButton: HexButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let hexFrame = calculateFrame()
        
        let hexagonWidth = hexFrame.width / 3
        let topBottomPadding = (hexFrame.height - hexagonWidth * 3) / 2
        let differenceHeight = hexagonWidth * CGFloat(sin(Double.pi/6))
        let differenceWidth = hexagonWidth * CGFloat(cos(Double.pi/6))
        self.view.backgroundColor = UIColor.white
        
        serialButton = HexButton(frame: CGRect(x: hexFrame.midX - differenceWidth / 2 - hexagonWidth / 2, y: hexFrame.origin.y + topBottomPadding, width: hexagonWidth, height: hexagonWidth))
        serialButton.text = "Serial"
        serialButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(serialButton)
        
        TSOPButton = HexButton(frame: CGRect(x: hexFrame.midX + differenceWidth / 2 - hexagonWidth / 2, y: serialButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth))
        TSOPButton.text = "TSOP"
        TSOPButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(TSOPButton)
        
        lightButton = HexButton(frame: CGRect(x: hexFrame.midX - differenceWidth / 2 - hexagonWidth / 2, y: TSOPButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth))
        lightButton.text = "Light"
        lightButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(lightButton)
        
        compassButton = HexButton(frame: CGRect(x: hexFrame.midX + differenceWidth / 2 - hexagonWidth / 2, y: lightButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth))
        compassButton.text = "Compass"
        compassButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(compassButton)
        
        designButton = HexButton(frame: CGRect(x: hexFrame.midX - differenceWidth / 2 - hexagonWidth / 2, y: compassButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth))
        designButton.text = "Design"
        designButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(designButton)
    }
    
    func calculateFrame() -> CGRect {
        let windowFrame = self.view.bounds
        let maxSize = windowFrame.size.width > windowFrame.size.height ? windowFrame.size.height * 0.9 : windowFrame.size.width * 0.9
        let returnFrame = CGRect(x: windowFrame.origin.x + windowFrame.size.width / 2 - maxSize / 2, y: windowFrame.origin.y + windowFrame.size.height / 2 - maxSize / 2, width: maxSize, height: maxSize)
        
        return returnFrame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateButtons()
    }
    
    func windowWasResized() {
        updateButtons()
    }
    
    func updateButtons() {
        let hexFrame = calculateFrame()
        
        let hexagonWidth = hexFrame.width / 3
        let topBottomPadding = (hexFrame.height - hexagonWidth * 3) / 2
        let differenceHeight = hexagonWidth * CGFloat(sin(Double.pi/6))
        let differenceWidth = hexagonWidth * CGFloat(cos(Double.pi/6))
        
        serialButton.frame = CGRect(x: hexFrame.midX - differenceWidth / 2 - hexagonWidth / 2, y: hexFrame.origin.y + topBottomPadding, width: hexagonWidth, height: hexagonWidth)
    
        TSOPButton.frame = CGRect(x: hexFrame.midX + differenceWidth / 2 - hexagonWidth / 2, y: serialButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth)
    
    
        lightButton.frame = CGRect(x: hexFrame.midX - differenceWidth / 2 - hexagonWidth / 2, y: TSOPButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth)
    
    
        compassButton.frame = CGRect(x: hexFrame.midX + differenceWidth / 2 - hexagonWidth / 2, y: lightButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth)
    
    
        designButton.frame = CGRect(x: hexFrame.midX - differenceWidth / 2 - hexagonWidth / 2, y: compassButton.frame.origin.y + differenceHeight, width: hexagonWidth, height: hexagonWidth)

    }
    
    func buttonTapped(_ sender: UIButton) {
        if let hexButton = sender as? HexButton {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWindow"), object: hexButton.text)
        }
    }
}
