//
//  TypeAlias.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 20/3/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation

#if os(macOS)
    import Cocoa
    typealias Color = NSColor
    typealias View = NSView
    typealias BezierPath = NSBezierPath
    typealias Point = NSPoint
#else
    import UIKit
    typealias Color = UIColor
    typealias View = UIView
    typealias BezierPath = UIBezierPath
    typealias Point = CGPoint
#endif
