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

class SerialViewController: UIViewController, AnimationViewController {
    internal var tappedButton: UIButton?

    
    @IBOutlet weak var sendTextField: UITextField!
    @IBOutlet weak var serialOutputTextView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var connectCount = 0

    var titleView: TitleView!
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    var selectedPeripheral: CBPeripheral?
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        
        BluetoothController.shared.serialDelegate = self
        
        titleView = TitleView(frame: CGRect(origin: CGPoint(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 20.0), size: CGSize(width: self.view.frame.width, height: 80.0)), title: "Serial")
    
        self.view.addSubview(titleView)
        
        reloadView()
        serialOutputTextView.text = ""
        
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
        if !serial.isReady {
            connectCount = 0
            BluetoothController.shared.connect()
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SerialViewController: BluetoothControllerSerialDelegate {
    func hasNewOutput(serial: String) {
        serialOutputTextView.text = serial
        serialOutputTextView.scrollToBotom()
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
