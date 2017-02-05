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
    public var hasText: Bool {
        return true
    }

    @IBOutlet weak var serialOutputTextView: UITextView!
    
    var connectCount = 0
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    var selectedPeripheral: CBPeripheral?
    var blinkOn: Bool = false
    
    var enteredText: String = ""
    var previousText: String = ""
    
    override func viewDidLoad() {
        BluetoothController.shared.serialDelegate = self
        reloadView()
        serialOutputTextView.text = ""
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showHideKeyboard))
        view.addGestureRecognizer(tap)
        
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.blink), userInfo: nil, repeats: true)
    }
    
    func blink() {
        blinkOn = !blinkOn
        
        updateText()
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
    
    func showHideKeyboard() {
        if !self.isFirstResponder {
            self.becomeFirstResponder()
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
    }
    
    func send() {
        if enteredText != "" {
            serial.sendMessageToDevice(enteredText)
            previousText += ">" + enteredText + "\n"
            enteredText = ""
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
        serialOutputTextView.scrollToBotom()
    }
}

extension SerialViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        return true
    }
}
