//
//  UIBezierPath.swift
//  LJ STAND
//
//  Created by James Yelland on 29/1/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

extension UIBezierPath {
    static func polygonIn(rect: CGRect, numberOfSides: Int, rotationOffset: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let theta = CGFloat(2.0 * M_PI) / CGFloat(numberOfSides)
        let width = min(rect.size.width, rect.size.height)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let radius = width / 2.0
        
        var angle = rotationOffset
        
        let corner = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
        path.move(to: corner)
        
        for _ in 0..<numberOfSides {
            angle += theta
            let corner = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            path.addLine(to: corner)
        }
        
        path.close()
        
        return path
    }
}
