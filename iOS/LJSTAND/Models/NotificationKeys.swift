//
//  NotificationKeys.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 7/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation

struct NotificationKeys {
    static let base = "com.lachlangrant.LJSTAND.Notifications"
    static let addedWindow = Notification.Name(rawValue: base + ".addedWindow")
    static let closedWindow = Notification.Name(rawValue: base + ".closedWindow")
}
