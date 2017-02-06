//
//  SerialViewController.swift
//  LJSTAND
//
//  Created by Lachlan Grant on 12/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import MKUtilityKit
import MKUIKit
import CoreBluetooth
import Chameleon

class SerialViewController: UIViewController, UIKeyInput, UITextInputTraits, ResizableViewController {
    public var hasText: Bool {
        return true
    }

    @IBOutlet weak var serialOutputTextView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var connectCount = 0
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    var selectedPeripheral: CBPeripheral?
    var blinkOn: Bool = false
    
    var enteredText: String = ""
    var previousText: String = ""
    
    var keyboardFrame: CGRect = CGRect.zero
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        
        BluetoothController.shared.serialDelegate = self
        reloadView()
        serialOutputTextView.text = ""
        serialOutputTextView.layoutManager.allowsNonContiguousLayout = false
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.blink), userInfo: nil, repeats: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        var info = (notification as NSNotification).userInfo!
        let value = info[UIKeyboardFrameEndUserInfoKey] as! NSValue
        keyboardFrame = value.cgRectValue
        
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            if let window = UIApplication.shared.keyWindow {
                let difference = -((UIScreen.main.bounds.height - (window.frame.origin.y + window.frame.height - kWindowResizeGutterSize)) - self.keyboardFrame.size.height)
                self.bottomConstraint.constant = difference > 0 ? difference : 0
            }
        }, completion: { Bool -> Void in
            self.serialOutputTextView.scrollToBottom()
        })
    }
    
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.bottomConstraint.constant = 0
        }, completion: nil)
        
    }
    
    func windowWasResized() {
        if self.isFirstResponder {
            UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
                if let window = UIApplication.shared.keyWindow {
                    let difference = -((UIScreen.main.bounds.height - (window.frame.origin.y + window.frame.height - kWindowResizeGutterSize)) - self.keyboardFrame.size.height)
                    self.bottomConstraint.constant = difference > 0 ? difference : 0
                }
            }, completion: { Bool -> Void in
                self.serialOutputTextView.scrollToBottom()
            })
        }
    }
    
    func windowWasMoved() {
        resignFirstResponder()
    }
    
    override func becomeFirstResponder() -> Bool {
        return false
    }
    
    func superBecomeFirstResponder() {
        super.becomeFirstResponder()
    }
    
    func blink() {
        blinkOn = !blinkOn
        
        updateTextNoScroll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func reloadView() {
        if !serial.isReady {
            connectCount = 0
            if !UIDevice.current.isSimulator {
                BluetoothController.shared.connect()
            }
        }
    }
    
    func showHideKeyboard(_ rec: UIGestureRecognizer) {
        if !self.isFirstResponder {
            if let navVC = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                if navVC.visibleViewController == self {
                    if let window = UIApplication.shared.keyWindow as? WMWindow {
                        let point = rec.location(in: window)
                        let titleBarRect: CGRect = CGRectMake(window.bounds.origin.x, window.bounds.origin.y, window.bounds.size.width, kMoveGrabHeight)

                        if !titleBarRect.contains(point) {
                            super.becomeFirstResponder()
                        }
                    }
                }
            }
        } else {
            self.resignFirstResponder()
        }
    }

    func insertText(_ text: String) {
        if text == "\n" {
            send()
        } else {
            enteredText.append(text)
            updateText()
        }
    }
    
    func deleteBackward() {
        if enteredText != "" {
           enteredText.remove(at: enteredText.index(before: enteredText.endIndex))
        }
        
        updateText()
    }
    
    func updateText() {
        serialOutputTextView.text = previousText + ">" + enteredText + (blinkOn ? "_" : "")
        serialOutputTextView.scrollToBottom()
    }
    
    func updateTextNoScroll() {
        serialOutputTextView.text = previousText + ">" + enteredText + (blinkOn ? "_" : "")
    }
    
    func send() {
        if enteredText != "" {
            serial.sendMessageToDevice(enteredText)
            previousText += ">" + enteredText + "\n"
            enteredText = ""
            updateText()
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    var returnKeyType: UIReturnKeyType {
        return UIReturnKeyType.send
    }
}

extension SerialViewController: BluetoothControllerSerialDelegate {
    func hasNewOutput(serial: String) {
        previousText += serial + "\n"
        updateText()
    }
}
