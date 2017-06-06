//
//  BluetoothController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

/*
 This file contains delegates, connection functions & class variables
*/

import Foundation
import CoreBluetooth
import MKKit
import MKUtilityKit
import UIKit

class BluetoothController {
    static let shared = BluetoothController()
    
    var serialDelegate: BluetoothControllerSerialDelegate?
    var tsopDelegate: BluetoothControllerTSOPDelegate?
    var compassDelegate: BluetoothControllerCompassDelegate?
    var lightSensDelegate: BluetoothControllerLightSensorDelegate?
    var messageDelegate: BluetoothMessageDelegate?
    var settingsDelegate: BluetoothControllerSettingsDelegate?
    var robotPositionDelegate: BluetoothControllerRobotPositionDelegate?
    var sendingDelegate: BluetoothControllerSendDelegate?
    
    var peripherals: [CBPeripheral] = []
    var rssis: [Float] = []
    var selectedPeripheral: CBPeripheral?
    var connectCount = 0
    var overrideConnect: Bool = false
    
    var connected: Bool = false
    var bluetoothDebug: Bool = false
    
    var textRecieved = ""
    
    init() {
        self.debugBluetooth(message: "init()")
        serial = BluetoothSerial(delegate: self)
        serial.writeType = .withoutResponse
        sendingDelegate = self
        checkConnect()
    }
    
    func checkDisabledStatus() -> Bool {
        self.debugBluetooth(message: "checkDisabledStatus()")
        let bluetooth = MKUPermission.bluetooth
        let status = bluetooth.status
        
        if status == .denied || status == .disabled || status == .notDetermined || UIDevice.current.isSimulator == true {
            return true
        }
        
        return false
    }
    
    func checkConnect() {
        self.debugBluetooth(message: "checkConnect()")
        if self.connected == false && self.overrideConnect == false {
            connectCount = 0
            self.connect()
        }
    }
    
    func connectTo(_ peripheral: CBPeripheral) {
        self.selectedPeripheral = peripheral
        serial.connectToPeripheral(peripheral)
    }
    
    func connect() {
        self.debugBluetooth(message: "connect()")
        if !overrideConnect && connectCount < 3 {
            
            MKUAsync.main({ () -> Bool in
                self.messageDelegate?.showInformation("Scanning for Bluetooth Devices...")
                return true
            }).background({ (prev: Bool) -> Bool in
                serial.startScan()
                sleep(2)
                
                return prev
            }).main({ (prev: Bool) -> Bool in
                serial.stopScan()
                
                if self.peripherals.count > 0 {
                    let lastDevice = UserDefaults.standard.string(forKey: "lastConnected")
                    
                    var last: CBPeripheral?
                    for device in self.peripherals {
                        if device.name == lastDevice {
                            last = device
                        }
                    }
                    
                    if last != nil {
                        self.selectedPeripheral = last!
                        serial.connectToPeripheral(last!)
                    } else {
                        self.messageDelegate?.foundDevices(self.peripherals)
                    }
                } else {
                    var count = self.connectCount
                    count = count + 1
                    self.connectCount = count
                    self.connect()
                }
                
                return prev
            })
        } else {
            messageDelegate?.dismissNotifications()
        }
    }
    
    fileprivate func debugBluetooth(message: String) {
        if self.bluetoothDebug == true {
            MKULog.shared.debug(message)
            MKULog.shared.debug("Connected, Override, Peripherals")
            MKULog.shared.debug([self.connected, self.overrideConnect, self.peripherals])
            MKULog.shared.mark()
        }
    }
}
