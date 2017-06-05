//
//  BluetoothProtocols.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 6/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

/*
 BluetoothController Protocols
*/

import Foundation
import CoreBluetooth

protocol BluetoothMessageDelegate {
    func showInformation(_ message: String)
    func showError(_ message: String)
    func foundDevices(_ peripherals: [CBPeripheral])
    func dismissNotifications()
}

protocol BluetoothControllerSerialDelegate {
    func hasNewOutput(_ serial: String)
}

protocol BluetoothControllerTSOPDelegate {
    func hasNewDirection(_ angle: Double)
    func hasNewOrbitAngle(_ angle: Double)
}

protocol BluetoothControllerCompassDelegate {
    func hasNewHeading(_ angle: Double)
}

protocol BluetoothControllerLightSensorDelegate {
    func updatedCurrentLightSensors(_ sensors: [Int])
}

protocol BluetoothControllerSettingsDelegate {
    func updatedSettings(compass: Bool, light: Bool, tsop: Bool)
}

protocol BluetoothControllerSendDelegate {
    func pollForRobotNumber()
    func requestSettings()
    func sendSettings(compass: Bool, tsop: Bool, light: Bool)
}

protocol BluetoothControllerRobotPositionDelegate {
    func updatePosition(position: RobotPosition)
}
