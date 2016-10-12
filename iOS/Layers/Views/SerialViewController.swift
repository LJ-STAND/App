//
//  SerialViewController.swift
//  LJSTAND
//
//  Created by Lachlan Grant on 12/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import CoreBluetooth

class SerialViewController: UIViewController {
    
    @IBOutlet weak var sendTextField: UITextField!
    @IBOutlet weak var serialOutputTextView: UITextView!
    
    override func viewDidLoad() {
        serial = BluetoothSerial(delegate: self)
        if !serial.isReady {
            //TODO: Present a connect view controller
        }
        
        serial.writeType = .withoutResponse
    }
    
    @IBAction func sendAction(_ sender: Any) {
        guard let textToSend = sendTextField.text else {
            return
        }
        
        serial.sendMessageToDevice(textToSend)
    }
}


extension SerialViewController: BluetoothSerialDelegate {
    
    func serialDidReceiveString(_ message: String) {
        //TODO: Append to TextView
    }
    
    func serialDidChangeState() {
        //TODO: Handle State Changes (eg. Disconnect)
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        //TODO: Handle Disconnect
    }
}
