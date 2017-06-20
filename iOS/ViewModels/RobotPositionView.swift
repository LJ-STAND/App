//
//  RobotPositionView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 8/5/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation
import UIKit
import MKUtilityKit

class RobotPositionView: UIView {
    fileprivate let horizontalLineOffset = 60.0
    fileprivate let verticalOffset = 60.0
    fileprivate let robot = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    fileprivate var field = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    override init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    fileprivate func sharedInit() {
        BluetoothController.shared.checkConnect()
        
        robot.backgroundColor = .blue
        
        field = UIImageView(frame: CGRect(x: horizontalLineOffset, y: verticalOffset, width: (Double(self.bounds.width) - (2 * horizontalLineOffset)), height: (Double(self.bounds.height) - (2 * verticalOffset))))
        
        field.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(field)
        
        self.addConstraint(NSLayoutConstraint(item: field, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: CGFloat(horizontalLineOffset)))
        
        self.addConstraint(NSLayoutConstraint(item: field, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: CGFloat(-horizontalLineOffset)))
        
        self.addConstraint(NSLayoutConstraint(item: field, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: CGFloat(verticalOffset)))
        
        self.addConstraint(NSLayoutConstraint(item: field, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: CGFloat(-verticalOffset)))
        
        self.layoutIfNeeded()
        
        field.image = UIImage(named: "Field")
        
        self.backgroundColor = .clear
        self.addSubview(robot)
        
        self.sendSubview(toBack: robot)
        self.sendSubview(toBack: field)
    }
    
    public func setRobotPosition(_ pos: RobotPosition) {
        let size: CGFloat = 50.0
        var position = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        
        switch pos {
            
        case .smallOnFrontLine:
            position.origin = CGPoint(x: ((self.frame.width / 2.0) - CGFloat(size / 2.0)), y: (CGFloat(2.0 * verticalOffset) - size))
            
        case .bigOnFrontLine:
            position.origin = CGPoint(x: ((self.frame.width / 2.0) - CGFloat(size / 2.0)), y: (CGFloat(1.5 * verticalOffset) - size))
            
        case .overFrontLine:
            position.origin = CGPoint(x: ((self.frame.width / 2.0) - CGFloat(size / 2.0)), y: (CGFloat(verticalOffset) - size))
            
        case .smallOnRightLine:
            position.origin = CGPoint(x: ((self.frame.width - CGFloat(2.0 * horizontalLineOffset))), y: (self.frame.height / 2))
            
        case .bigOnRightLine:
            position.origin = CGPoint(x: ((self.frame.width - CGFloat(1.5 * horizontalLineOffset))), y: (self.frame.height / 2))
            
        case .overRightLine:
            position.origin = CGPoint(x: ((self.frame.width - CGFloat(horizontalLineOffset))), y: (self.frame.height / 2))
            
        case .smallOnBackLine:
            position.origin = CGPoint(x: (self.frame.width / 2.0), y: ((self.frame.height - CGFloat(2.0 * verticalOffset))))
            
        case .bigOnBackLine:
            position.origin = CGPoint(x: (self.frame.width / 2.0), y: ((self.frame.height - CGFloat(1.5 * verticalOffset))))
            
        case .overBackLine:
            position.origin = CGPoint(x: (self.frame.width / 2.0), y: ((self.frame.height - CGFloat(verticalOffset))))
            
        case .smallOnLeftLine:
            position.origin = CGPoint(x: CGFloat(2.0 * horizontalLineOffset) - size, y: ((self.frame.height / 2.0)))
            
        case .bigOnLeftLine:
            position.origin = CGPoint(x: CGFloat(1.5 * horizontalLineOffset) - size, y: ((self.frame.height / 2.0)))
            
        case .overLeftLine:
            position.origin = CGPoint(x: CGFloat(horizontalLineOffset) - size, y: ((self.frame.height / 2.0)))
            
        case .smallOnCornerFrontRight:
            position.origin = CGPoint(x: ((self.frame.width - CGFloat(2.0 * horizontalLineOffset))), y: (CGFloat(2.0 * verticalOffset) - size))
            
        case .bigOnCornerFrontRight:
            position.origin = CGPoint(x: ((self.frame.width - CGFloat(1.5 * horizontalLineOffset))), y: (CGFloat(1.5 * verticalOffset) - size))
            
        case .overCornerFrontRight:
            position.origin = CGPoint(x: ((self.frame.width - CGFloat(horizontalLineOffset))), y: (CGFloat(verticalOffset) - size))
            
        case .smallOnCornerBackRight:
            position.origin = CGPoint(x: ((self.frame.width - CGFloat(2.0 * horizontalLineOffset))), y: (self.frame.height - CGFloat(2.0 * verticalOffset)))
            
        case .bigOnCornerBackRight:
            position.origin = CGPoint(x: ((self.frame.width - CGFloat(1.5 * horizontalLineOffset))), y: (self.frame.height - CGFloat(1.5 * verticalOffset)))
            
        case .overCornerBackRight:
            position.origin = CGPoint(x: ((self.frame.width - CGFloat(horizontalLineOffset))), y: (self.frame.height - CGFloat(verticalOffset)))
            
        case .smallOnCornerBackLeft:
            position.origin = CGPoint(x: (CGFloat(2.0 * horizontalLineOffset) - size), y: (self.frame.height - CGFloat(2.0 * verticalOffset)))
            
        case .bigOnCornerBackLeft:
            position.origin = CGPoint(x: (CGFloat(1.5 * horizontalLineOffset) - size), y: (self.frame.height - CGFloat(1.5 * verticalOffset)))
            
        case .overCornerBackLeft:
            position.origin = CGPoint(x: (CGFloat(horizontalLineOffset) - size), y: (self.frame.height - CGFloat(verticalOffset)))
            
        case .smallOnCornerFrontLeft:
            position.origin = CGPoint(x: CGFloat(2.0 * horizontalLineOffset) - size, y: CGFloat(2.0 * verticalOffset) - size)
            
        case .bigOnCornerFrontLeft:
            position.origin = CGPoint(x: CGFloat(1.5 * horizontalLineOffset) - size, y: CGFloat(1.5 * verticalOffset) - size)
            
        case .overCornerFrontLeft:
            position.origin = CGPoint(x: CGFloat(horizontalLineOffset) - size, y: CGFloat(verticalOffset) - size)
            
        case .field:
            position.origin = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        }
        
        MKUAsync.main {
            self.robot.frame = position
        }
    }
}
