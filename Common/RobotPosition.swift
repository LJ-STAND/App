//
//  RobotPosition.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 8/5/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation

enum RobotPosition: Int {
    case smallOnFrontLine
    case bigOnFrontLine
    case overFrontLine
    case smallOnRightLine
    case bigOnRightLine
    case overRightLine
    case smallOnBackLine
    case bigOnBackLine
    case overBackLine
    case smallOnLeftLine
    case bigOnLeftLine
    case overLeftLine
    case smallOnCornerFrontRight
    case bigOnCornerFrontRight
    case overCornerFrontRight
    case smallOnCornerBackRight
    case bigOnCornerBackRight
    case overCornerBackRight
    case smallOnCornerBackLeft
    case bigOnCornerBackLeft
    case overCornerBackLeft
    case smallOnCornerFrontLeft
    case bigOnCornerFrontLeft
    case overCornerFrontLeft
    case field // Default, kinda
}
