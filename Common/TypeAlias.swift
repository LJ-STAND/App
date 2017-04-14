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
    typealias Rect = NSRect
#else
    import UIKit
    typealias Color = UIColor
    typealias View = UIView
    typealias BezierPath = UIBezierPath
    typealias Point = CGPoint
    typealias Rect = CGRect
#endif



func RectFill(_ rect: Rect) {
    #if os(macOS)
    NSRectFill(rect)
    #else
    UIRectFill(rect)
    #endif
}
