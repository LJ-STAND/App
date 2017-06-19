//
//  PixyView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 15/6/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class PixyView: UIView {
    private let maxPixyHeight = 180.0
    private let maxPixyWidth = 320.0
    
    var outline: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.outline = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        outline.backgroundColor = .clear
        outline.layer.borderColor = UIColor.white.cgColor
        outline.layer.borderWidth = CGFloat(5.0)
        
        self.addSubview(outline)
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = CGFloat(5.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func applyNewPixyData(x: Double, y: Double, width: Double, height: Double) {
        let xPercentage = (x / maxPixyWidth)
        let yPercentage = (y / maxPixyHeight)
        
        let widthPercentage = (width / maxPixyWidth)
        let heightPercetage = (height / maxPixyHeight)
        
        let xPoint = xPercentage * Double(self.frame.width)
        let yPoint = yPercentage * Double(self.frame.height)
        
        let width = widthPercentage * Double(self.frame.width)
        let height = heightPercetage * Double(self.frame.width)
        
        
        let newBounds = CGRect(x: xPoint, y: yPoint, width: width, height: height)
        
        outline.frame = newBounds
        outline.bounds = newBounds
    }
}
