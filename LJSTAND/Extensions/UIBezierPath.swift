//
//  UIBezierPath.swift
//  LJ STAND
//
//  Created by James Yelland on 29/1/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

extension UIBezierPath {
    static func roundedPolygonIn(_ rect: CGRect, numberOfSides: Int, cornerRadius: CGFloat, lineWidth: CGFloat, rotationOffset: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let theta = CGFloat(2.0 * Double.pi) / CGFloat(numberOfSides)
        let offset = cornerRadius * tan(theta)
        let width = min(rect.size.width, rect.size.height)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
        
        var angle = rotationOffset
        
        let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
        path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))
        
        for _ in 0..<numberOfSides {
            angle += theta
            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
            
            let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
            let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))

            path.addLine(to: start)
            path.addQuadCurve(to: end, controlPoint: tip)
        }
        
        path.close()
        
        return path
    }
}
