//
//  BluetoothSerial.swift
//  Layers
//
//  Created by Lachlan Grant on 11/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import CoreBluetooth

var serial: BluetoothSerial!

protocol BluetoothSerialDelegate {
    func serialDidChangeState()
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?)
    func serialDidReceiveString(_ message: String)
    func serialDidReceiveBytes(_ bytes: [UInt8])
    func serialDidReceiveData(_ data: Data)
    func serialDidReadRSSI(_ rssi: NSNumber)
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?)
    func serialDidConnect(_ peripheral: CBPeripheral)
    func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?)
    func serialIsReady(_ peripheral: CBPeripheral)
}

extension BluetoothSerialDelegate {
    func serialDidReceiveString(_ message: String) {}
    func serialDidReceiveBytes(_ bytes: [UInt8]) {}
    func serialDidReceiveData(_ data: Data) {}
    func serialDidReadRSSI(_ rssi: NSNumber) {}
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {}
    func serialDidConnect(_ peripheral: CBPeripheral) {}
    func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?) {}
    func serialIsReady(_ peripheral: CBPeripheral) {}
}


final class BluetoothSerial: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var delegate: BluetoothSerialDelegate!
    var centralManager: CBCentralManager!
    var pendingPeripheral: CBPeripheral?
    var connectedPeripheral: CBPeripheral?
    weak var writeCharacteristic: CBCharacteristic?

    var isReady: Bool {
        get {
            return centralManager.state == .poweredOn &&
                connectedPeripheral != nil &&
                writeCharacteristic != nil
        }
    }
    
    var writeType: CBCharacteristicWriteType = .withoutResponse

    init(delegate: BluetoothSerialDelegate) {
        super.init()
        self.delegate = delegate
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScan() {
        guard centralManager.state == .poweredOn else { return }
        
        let uuid = CBUUID(string: "FFE0")
        centralManager.scanForPeripherals(withServices: [uuid], options: nil)
        
        let peripherals = centralManager.retrieveConnectedPeripherals(withServices: [uuid])
        for peripheral in peripherals {
            delegate.serialDidDiscoverPeripheral(peripheral, RSSI: nil)
        }
    }
    
    func stopScan() {
        centralManager.stopScan()
    }
    
    func connectToPeripheral(_ peripheral: CBPeripheral) {
        pendingPeripheral = peripheral
        centralManager.connect(peripheral, options: nil)
    }
    
    func disconnect() {
        if let p = connectedPeripheral {
            centralManager.cancelPeripheralConnection(p)
        } else if let p = pendingPeripheral {
            centralManager.cancelPeripheralConnection(p)
        }
    }
    
    func readRSSI() {
        guard isReady else { return }
        connectedPeripheral!.readRSSI()
    }
    
    func sendMessageToDevice(_ message: String) {
        guard isReady else { return }
        
        if let data = message.data(using: String.Encoding.utf8) {
            connectedPeripheral!.writeValue(data, for: writeCharacteristic!, type: writeType)
        }
    }
    
    func sendBytesToDevice(_ bytes: [UInt8]) {
        guard isReady else { return }
        
        let data = Data(bytes: UnsafePointer<UInt8>(bytes), count: bytes.count)
        connectedPeripheral!.writeValue(data, for: writeCharacteristic!, type: writeType)
    }
    
    func sendDataToDevice(_ data: Data) {
        guard isReady else { return }
        
        connectedPeripheral!.writeValue(data, for: writeCharacteristic!, type: writeType)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        delegate.serialDidDiscoverPeripheral(peripheral, RSSI: RSSI)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        pendingPeripheral = nil
        connectedPeripheral = peripheral
        
        delegate.serialDidConnect(peripheral)
        
        peripheral.discoverServices([CBUUID(string: "FFE0")])
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        connectedPeripheral = nil
        pendingPeripheral = nil
        
        delegate.serialDidDisconnect(peripheral, error: error as NSError?)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        pendingPeripheral = nil
        delegate.serialDidFailToConnect(peripheral, error: error as NSError?)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        connectedPeripheral = nil
        pendingPeripheral = nil
        
        delegate.serialDidChangeState()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            peripheral.discoverCharacteristics([CBUUID(string: "FFE1")], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! {
            if characteristic.uuid == CBUUID(string: "FFE1") {
                peripheral.setNotifyValue(true, for: characteristic)
                
                writeCharacteristic = characteristic
                
                delegate.serialIsReady(peripheral)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let data = characteristic.value
        guard data != nil else { return }
        
        delegate.serialDidReceiveData(data!)
        
        if let str = String(data: data!, encoding: String.Encoding.utf8) {
            delegate.serialDidReceiveString(str)
        }
        
        var bytes = [UInt8](repeating: 0, count: data!.count / MemoryLayout<UInt8>.size)
        (data! as Data).copyBytes(to: &bytes, count: data!.count)
        delegate.serialDidReceiveBytes(bytes)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        delegate.serialDidReadRSSI(RSSI)
    }
}

