//
//  SerialViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 23/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Cocoa

class SerialViewController: NSViewController {
    @IBOutlet weak var serialTextView: NSTextView!
    @IBOutlet weak var messageTextField: NSTextField!
    
    override func viewDidLoad() {
        BluetoothController.shared.serialDelegate = self
        messageTextField.target = self
        messageTextField.action = #selector(self.sendMessageAction(_:))
    }
    
    @IBAction func sendMessageAction(_ sender: Any) {
        //TODO: Just for development testing
        serial.sendMessageToDevice(messageTextField.stringValue)
        messageTextField.stringValue = ""
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
