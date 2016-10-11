//
//  ScannerViewController.swift
//  Layers
//
//  Created by Lachlan Grant on 11/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import CoreBluetooth

class ScannerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BluetoothSerialDelegate {
    @IBOutlet weak var tryAgainButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    var selectedPeripheral: CBPeripheral?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tryAgainButton.isEnabled = false
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        serial.delegate = self
        
        if serial.centralManager.state != .poweredOn {
            title = "Bluetooth not turned on"
            return
        }
        
        serial.startScan()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ScannerViewController.scanTimeOut), userInfo: nil, repeats: false)
    }
    
    func scanTimeOut() {
        serial.stopScan()
        tryAgainButton.isEnabled = true
        title = "Done scanning"
    }
    
    func connectTimeOut() {
        
        if let _ = serial.connectedPeripheral {
            return
        }
        
//        if let hud = progressHUD {
//            hud.hide(false)
//        }
//        
//        if let _ = selectedPeripheral {
//            serial.disconnect()
//            selectedPeripheral = nil
//        }
//        
//        let hud = MBProgressHUD.showAdded(to: view, animated: true)
//        hud?.mode = MBProgressHUDMode.text
//        hud?.labelText = "Failed to connect"
//        hud?.hide(true, afterDelay: 2)
    }
    
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let label = cell.viewWithTag(1) as! UILabel!
        label?.text = peripherals[(indexPath as NSIndexPath).row].peripheral.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // the user has selected a peripheral, so stop scanning and proceed to the next view
        serial.stopScan()
        selectedPeripheral = peripherals[(indexPath as NSIndexPath).row].peripheral
        serial.connectToPeripheral(selectedPeripheral!)
//        progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
//        progressHUD!.labelText = "Connecting"

        //TODO: Disp Something
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ScannerViewController.connectTimeOut), userInfo: nil, repeats: false)
    }
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        // check whether it is a duplicate
        for exisiting in peripherals {
            if exisiting.peripheral.identifier == peripheral.identifier { return }
        }
        
        // add to the array, next sort & reload
        let theRSSI = RSSI?.floatValue ?? 0.0
        peripherals.append(peripheral: peripheral, RSSI: theRSSI)
        peripherals.sort { $0.RSSI < $1.RSSI }
        tableView.reloadData()
    }
    
    func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?) {
//        if let hud = progressHUD {
//            hud.hide(false)
//        }
        
        tryAgainButton.isEnabled = true
        
//        let hud = MBProgressHUD.showAdded(to: view, animated: true)
//        hud?.mode = MBProgressHUDMode.text
//        hud?.labelText = "Failed to connect"
//        hud?.hide(true, afterDelay: 1.0)
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
//        if let hud = progressHUD {
//            hud.hide(false)
//        }
        
        tryAgainButton.isEnabled = true
        
//        let hud = MBProgressHUD.showAdded(to: view, animated: true)
//        hud?.mode = MBProgressHUDMode.text
//        hud?.labelText = "Failed to connect"
//        hud?.hide(true, afterDelay: 1.0)
        
    }
    
    func serialIsReady(_ peripheral: CBPeripheral) {
//        if let hud = progressHUD {
//            hud.hide(false)
//        }
//        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadStartViewController"), object: self)
        dismiss(animated: true, completion: nil)
    }
    
    func serialDidChangeState() {
//        if let hud = progressHUD {
//            hud.hide(false)
//        }
        
        if serial.centralManager.state != .poweredOn {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadStartViewController"), object: self)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        // go back
        serial.stopScan()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tryAgain(_ sender: AnyObject) {
        // empty array an start again
        peripherals = []
        tableView.reloadData()
        tryAgainButton.isEnabled = false
        title = "Scanning ..."
        serial.startScan()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ScannerViewController.scanTimeOut), userInfo: nil, repeats: false)
    }
    
}
