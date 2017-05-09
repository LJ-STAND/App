//
//  ViewManager.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 9/5/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation

protocol ViewManager {
    func changeView(_ viewName: String)
    func clearView()
}
