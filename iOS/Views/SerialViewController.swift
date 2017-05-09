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

class SerialViewController: UIViewController, UIKeyInput, UITextInputTraits {
    open var hasText: Bool {
        return true
    }

    var serialOutputTextView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var connectCount = 0
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    var selectedPeripheral: CBPeripheral?
    var blinkOn: Bool = false
    var windowView: WindowView!
    
    var enteredText: String = ""
    var previousText: String = ""
    
    var keyboardFrame: CGRect = CGRect.zero
    
    override func viewDidLoad() {
        windowView = WindowView(frame: self.view.frame)
        self.view = windowView
        
        serialOutputTextView = UITextView()
        serialOutputTextView.font = UIFont(name: "Menlo", size: 17.0)
        serialOutputTextView.textAlignment = .left
        serialOutputTextView.textColor = UIColor.white
        serialOutputTextView.backgroundColor = UIColor.clear
        
        windowView.contentView = serialOutputTextView
        windowView.title = "SERIAL"
        
        BluetoothController.shared.serialDelegate = self
        reloadView()
        serialOutputTextView.text = ""
        serialOutputTextView.layoutManager.allowsNonContiguousLayout = false
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        self.serialOutputTextView.scrollToBottom()
    }
    
    func keyboardWillHide(_ notification: Notification) {}
    
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
                    if let window = UIApplication.shared.keyWindow {
                        let point = rec.location(in: window)
                        super.becomeFirstResponder()
                        //TODO: Test
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
            enteredText.append("> " + text)
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
    
    fileprivate var returnKeyType: UIReturnKeyType {
        return UIReturnKeyType.send
    }
}

extension SerialViewController: BluetoothControllerSerialDelegate {
    func hasNewOutput(_ serial: String) {
        previousText += serial + "\n"
        updateText()
    }
}
