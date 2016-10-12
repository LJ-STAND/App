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
import CRToast
import Chameleon

class SerialViewController: UIViewController {
    
    @IBOutlet weak var sendTextField: UITextField!
    @IBOutlet weak var serialOutputTextView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    var selectedPeripheral: CBPeripheral?
    
    override func viewDidLoad() {
        serial = BluetoothSerial(delegate: self)
        if !serial.isReady {
            connect()
        }
        serialOutputTextView.text = ""
        serial.writeType = .withoutResponse
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func textViewScrollToBottom() {
        let range = NSMakeRange(NSString(string: serialOutputTextView.text).length - 1, 1)
        serialOutputTextView.scrollRangeToVisible(range)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func connect() {
        MKAsync.main {
            CRToastManager.dismissAllNotifications(true)
            
            let options = [
                kCRToastTextKey: "Scanning for Bluetooth Devices...",
                kCRToastTextAlignmentKey: NSTextAlignment.center,
                kCRToastBackgroundColorKey: UIColor.flatBlue()
                ] as [String : Any]
            
            CRToastManager.showNotification(options: options, completionBlock: {})
        }.background {
            serial.startScan()
            sleep(2)
        }.main {
            serial.stopScan()
            
            if self.peripherals.count > 0 {
                let alert = UIAlertController(title: "Connect to Device", message: nil, preferredStyle: .alert)
                
                for item in self.peripherals {
                    alert.addAction(UIAlertAction(title: item.peripheral.name, style: UIAlertActionStyle.default, handler: { (action) in
                        self.selectedPeripheral = item.peripheral
                        serial.connectToPeripheral(item.peripheral)
                    }))
                }
                
                self.present(alert, animated: true, completion: nil)
            } else {
                CRToastManager.dismissAllNotifications(false)
                self.connect()
            }
        }
    }
    
    @IBAction func sendAction(_ sender: Any) {
        guard let textToSend = sendTextField.text else {
            return
        }
        
        serial.sendMessageToDevice(textToSend)
    }
}


extension SerialViewController: BluetoothSerialDelegate {
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        
        for exisiting in peripherals {
            if exisiting.peripheral.identifier == peripheral.identifier { return }
        }
        
        // add to the array, next sort & reload
        let theRSSI = RSSI?.floatValue ?? 0.0
        peripherals.append(peripheral: peripheral, RSSI: theRSSI)
        peripherals.sort { $0.RSSI < $1.RSSI }
        
        log.debug("Found Device")
    }
    
    func serialDidConnect(_ peripheral: CBPeripheral) {
        let options = [
            kCRToastTextKey: "Connected to \(peripheral.name!)!",
            kCRToastTextAlignmentKey: NSTextAlignment.center,
            kCRToastBackgroundColorKey: UIColor.flatGreen()
            ] as [String : Any]
        
        CRToastManager.showNotification(options: options, completionBlock: {})
        
        let text = "Connected to \(peripheral.name!) \n\n"
        serialOutputTextView.text = text
        
    }
    
    func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?) {
        let options = [
            kCRToastTextKey: "Connection Failed. \(error?.localizedDescription)",
            kCRToastTextAlignmentKey: NSTextAlignment.center,
            kCRToastBackgroundColorKey: UIColor.flatRed()
            ] as [String : Any]
        
        CRToastManager.showNotification(options: options, completionBlock: {})
        sleep(1)
        connect()
    }
    
    func serialDidReceiveString(_ message: String) {
        var text = serialOutputTextView.text!
        text += message
        serialOutputTextView.text = text
        self.textViewScrollToBottom()
        log.debug("Recieved String")
    }
    
    func serialDidChangeState() {
        //TODO: Handle State Changes (eg. Disconnect)
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        connect()
    }
}
