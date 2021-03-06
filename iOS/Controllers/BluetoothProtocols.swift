//
//  BluetoothProtocols.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 6/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

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
    func hasNewDirection(_ angle: Double, robot: RobotNumber)
    func hasNewOrbitAngle(_ angle: Double, robot: RobotNumber)
}

protocol BluetoothControllerCompassDelegate {
    func hasNewHeading(_ angle: Double, robot: RobotNumber)
}

protocol BluetoothControllerLightSensorDelegate {
    func updatedCurrentLightSensors(_ sensors: [Int])
}

protocol BluetoothControllerSettingsDelegate {
    func updatedSettings(compass: Bool, light: Bool, tsop: Bool)
}

protocol BluetoothControllerSendDelegate {
    func requestSettings()
    func sendSettings(compass: Bool, tsop: Bool, light: Bool)
}

protocol BluetoothControllerRobotPositionDelegate {
    func updatePosition(angle: Double, size: Double, robot: RobotNumber)
}

protocol BluetoothControllerPixyDelegate {
    func updatedGoalInformation(x: Double, y: Double, width: Double, height: Double)
}
