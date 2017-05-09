//
//  AppSettingsProtocol.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 6/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation

protocol AppSettingsDelegate {
    func setDockOnRight(right: Bool)
}

protocol AppLogDelegate {
    func enableAppLogging(enabled: Bool)
}
