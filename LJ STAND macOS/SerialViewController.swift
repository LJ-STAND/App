//
//  SerialViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 23/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa
import MKUtilityKit
import MKKit

class SerialViewController: NSViewController {
    @IBOutlet weak var serialTextView: NSTextView!
    @IBOutlet weak var messageTextField: NSTextField!
    
    override func viewDidLoad() {
        BluetoothController.shared.serialDelegate = self
        messageTextField.target = self
        messageTextField.action = #selector(self.sendMessageAction(_:))
    }
    
    @IBAction func sendMessageAction(_ sender: Any) {
        if serial.connectedPeripheral != nil {
            serial.sendMessageToDevice(messageTextField.stringValue)
            messageTextField.stringValue = ""
        } else {
            let message = "[SERIAL] No Device Connected."
            BluetoothController.shared.messageDelegate?.showError(message)
            MKULog.shared.error(message)
        }
    }
    
    
    deinit {
        BluetoothController.shared.serialDelegate = nil
    }
}

extension SerialViewController: BluetoothControllerSerialDelegate {
    func hasNewOutput(_ serial: String) {
        guard let oldContent = serialTextView.string else {
            return
        }
        
        let newcontent = oldContent + serial + "\n"
        
        serialTextView.string = newcontent
        
        serialTextView.scrollToEndOfDocument(self)
    }
}
