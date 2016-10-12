//
//  TestingVC.swift
//  LJSTAND
//
//  Created by Lachlan Grant on 12/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import CoreBluetooth
import MKKit

class TestingVC: UIViewController, BluetoothSerialDelegate {
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    var selectedPeripheral: CBPeripheral?
    var light = false
    
    override func viewDidLoad() {
        serial = BluetoothSerial(delegate: self)
        serial.writeType = .withoutResponse
    }
    
    @IBAction func scanAction(_ sender: AnyObject) {
        log.debug("Starting Scan")
        serial.startScan()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(TestingVC.scanTimeout), userInfo: nil, repeats: false)
    }
    
    @IBAction func connectAction(_ sender: AnyObject) {
        log.debug("Connecting...")
        serial.stopScan()
        selectedPeripheral = peripherals[0].peripheral
        serial.connectToPeripheral(selectedPeripheral!)
        
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(TestingVC.connectTimeOut), userInfo: nil, repeats: false)
    }
    
    @IBAction func sendAction(_ sender: AnyObject) {
        light = !light
        
        if light {
            serial.sendMessageToDevice("48")
        } else {
            serial.sendMessageToDevice("0")
        }
    }
    
    @IBAction func disconnectAction(_ sender: AnyObject) {
        serial.disconnect()
        log.debug("Disconnecting")
    }
    
    func serialDidReceiveString(_ message: String) {
        log.debug(message)
    }
    
    func scanTimeout() {
        serial.stopScan()
        log.debug("Scan timeout")
    }
    
    func connectTimeOut() {
        if let _ = serial.connectedPeripheral {
            return
        }
        
        if let _ = selectedPeripheral {
            serial.disconnect()
            selectedPeripheral = nil
        }
        
        log.debug("Connection Failed")
    }
    
    
    func serialDidChangeState() {
        //reloadView()
        if serial.centralManager.state != .poweredOn {
            log.debug("Bluetooth Turned off")
        }
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        log.debug("Disconnected")
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
        
        log.debug("Found Device")
    }
    
    func serialIsReady(_ peripheral: CBPeripheral) {
        log.debug("Serial is Ready")
    }
}
