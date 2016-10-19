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

    var titleView: TitleView!
    
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    var selectedPeripheral: CBPeripheral?
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        
        titleView = TitleView(frame: CGRect(origin: CGPoint(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 20.0), size: CGSize(width: self.view.frame.width, height: 80.0)), title: "Serial")
    
        self.view.addSubview(titleView)
        
        serial = BluetoothSerial(delegate: self)
        reloadView()
        serialOutputTextView.text = ""
        serial.writeType = .withoutResponse
        
        sendTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        bottomView.layer.masksToBounds = false
        bottomView.layer.shadowOffset = CGSize(width: 0, height: -1)
        bottomView.layer.shadowRadius = 0
        bottomView.layer.shadowOpacity = 0.5
        bottomView.layer.shadowColor = UIColor.gray.cgColor
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        var info = (notification as NSNotification).userInfo!
        let value = info[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrame = value.cgRectValue
        
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height - 50
        }, completion: { Bool -> Void in
            self.serialOutputTextView.scrollToBotom()
        })
    }
    
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.bottomConstraint.constant = 0
        }, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func reloadView() {
        serial.delegate = self
        
        if !serial.isReady {
            connect()
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func connect() {
        
        if Platform.isSimulator {
            return
        }
        
        MKAsync.main {
            if !CRToastManager.isShowingNotification() {
                let options = [
                    kCRToastTextKey: "Scanning for Bluetooth Devices...",
                    kCRToastBackgroundColorKey: UIColor.flatBlue(),
                    kCRToastKeepNavigationBarBorderKey: true
                    ] as [String : Any]
                
                CRToastManager.showNotification(options: options, completionBlock: {})
            }
        }.background {
            serial.startScan()
            sleep(2)
        }.main {
            serial.stopScan()
            
            if self.peripherals.count > 0 {
                
                let lastDevice = UserDefaults.standard.string(forKey: "lastConnected")
                
                var last: CBPeripheral?
                for device in self.peripherals {
                    if device.peripheral.name == lastDevice {
                        last = device.peripheral
                    }
                }
                
                if last != nil {
                    self.selectedPeripheral = last!
                    serial.connectToPeripheral(last!)
                } else {
                    let alert = UIAlertController(title: "Connect to Device", message: nil, preferredStyle: .alert)
                    
                    for item in self.peripherals {
                        alert.addAction(UIAlertAction(title: item.peripheral.name, style: UIAlertActionStyle.default, handler: { (action) in
                            self.selectedPeripheral = item.peripheral
                            serial.connectToPeripheral(item.peripheral)
                        }))
                    }
                    
                    self.present(alert, animated: true, completion: nil)

                }
            } else {
                self.connect()
            }
        }
    }
}

extension SerialViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textToSend = sendTextField.text else {
            return true
        }
        
        serial.sendMessageToDevice(textToSend)
        sendTextField.text = ""
        return true
    }
}


extension SerialViewController: BluetoothSerialDelegate {
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        
        for exisiting in peripherals {
            if exisiting.peripheral.identifier == peripheral.identifier { return }
        }
        
        let theRSSI = RSSI?.floatValue ?? 0.0
        peripherals.append(peripheral: peripheral, RSSI: theRSSI)
        peripherals.sort { $0.RSSI < $1.RSSI }
    }
    
    func serialDidConnect(_ peripheral: CBPeripheral) {
        let options = [
            kCRToastTextKey: "Connected to \(peripheral.name!)!",
            kCRToastBackgroundColorKey: UIColor.flatGreen()
            ] as [String : Any]
        
        CRToastManager.showNotification(options: options, completionBlock: {})
        
        let text = "Connected to \(peripheral.name!) \n\n"
        serialOutputTextView.text = text
        
        //Save Device Name
        UserDefaults.standard.set(peripheral.name!, forKey: "lastConnected")
    }
    
    func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?) {
        let options = [
            kCRToastTextKey: "Connection Failed. \(error?.localizedDescription)",
            kCRToastBackgroundColorKey: UIColor.flatRed()
            ] as [String : Any]
        
        CRToastManager.showNotification(options: options, completionBlock: {})
        sleep(1)
        connect()
    }
    
    func serialDidReceiveString(_ message: String) {
        let comps = message.components(separatedBy: ";")
        
        if comps.count > 1 {
            if comps[0] == "2" {
                let tsopstr = comps[1].trimmingCharacters(in: CharacterSet.init(charactersIn: "\r\n"))
                
                guard let active = Int(tsopstr) else {
                    return
                }
                
                let notif = Notification(name: NSNotification.Name(rawValue: "newActive"), object: active, userInfo: nil)
                NotificationCenter.default.post(notif)
            } else if comps[0] == "3" {
                let string = comps[1].trimmingCharacters(in: CharacterSet.init(charactersIn: "\r\n"))
                let boolArr = Array(string.characters)

                if boolArr.count == 12 {
                    var sensorStatus: [Int] = []
                    
                    for i in 0...11 {
                        let item = boolArr[i]
                        let intValue = Int(String(item))
                        
                        if intValue == 1 {
                            sensorStatus.append(1)
                            sensorStatus.append(0)
                        } else if intValue == 2 {
                            sensorStatus.append(0)
                            sensorStatus.append(1)
                        } else if intValue == 3 {
                            sensorStatus.append(1)
                            sensorStatus.append(1)
                        } else {
                            sensorStatus.append(0)
                            sensorStatus.append(0)
                        }
                        
                        var sensorNumbers: [Int] = []
                        
                        if sensorStatus.count == 24 {
                            for i in 0...23 {
                                let value = sensorStatus[i]
                                
                                if value == 1 {
                                    sensorNumbers.append(i)
                                }
                            }
                            
                            let notif = Notification(name: Notification.Name(rawValue: "newLights"), object: sensorNumbers, userInfo: nil)
                            NotificationCenter.default.post(notif)
                        }
                    }
                }
            } else if comps[0] == "4" {
                let ang = comps[1].trimmingCharacters(in: CharacterSet.init(charactersIn: "\r\n"))
                
                guard let angle = Double(ang) else {
                    return
                }
                
                let notif = Notification(name: Notification.Name(rawValue: "newCompass"), object: angle, userInfo: nil)
                NotificationCenter.default.post(notif)
            }
            
        } else {
            var text = serialOutputTextView.text!
            text += message
            serialOutputTextView.text = text
            self.serialOutputTextView.scrollToBotom()
        }
        
        
        
    }
    
    func serialDidChangeState() {
        connect()
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        connect()
    }
}
