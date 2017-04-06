//
//  BluetoothController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import Foundation
import CoreBluetooth
import MKKit
import MKUtilityKit

class BluetoothController {
    static let shared = BluetoothController()
    
    var serialDelegate: BluetoothControllerSerialDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    
    var tsopDelegate: BluetoothControllerTSOPDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    var compassDelegate: BluetoothControllerCompassDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    
    var lightSensDelegate: BluetoothControllerLightSensorDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    
    var messageDelegate: BluetoothMessageDelegate? {
        didSet {
            if !connected {
                connect()
            }
        }
    }
    
    
    var peripherals: [CBPeripheral] = []
    var rssis: [Float] = []
    var selectedPeripheral: CBPeripheral?
    var connectCount = 0
    var overrideConnect = false
    
    var connected: Bool = false
    var bluetoothDebug: Bool = false
    
    var textRecieved = ""
    
    init() {
        serial = BluetoothSerial(delegate: self)
        serial.writeType = .withoutResponse
    }
    
    func connectTo(_ peripheral: CBPeripheral) {
        self.selectedPeripheral = peripheral
        serial.connectToPeripheral(peripheral)
    }
    
    func connect() {
        if !overrideConnect && connectCount < 3 {
            MKUAsync.main {
                self.messageDelegate?.showInformation("Scanning for Bluetooth Devices...")
            }.background {_ in 
                serial.startScan()
                sleep(2)
            }.main {
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
            }
        } else {
            messageDelegate?.dismissNotifications()
        }
    }
}
