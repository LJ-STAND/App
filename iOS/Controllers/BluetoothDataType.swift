//
//  BluetoothDataType.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 6/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation

enum BluetoothDataType: Int {
    case noDataType
    case info
    case tsop
    case light
    case compass
    case rawData
    case linePosition
    case robotPoisition
    case settings
    case orbitAngle
}

enum RobotNumber: Int {
    case noRobot // No Robot Number was sent, just assume one robot set of data
    case one
    case two
}
