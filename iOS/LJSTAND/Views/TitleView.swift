//
//  TitleView.swift
//  LJ STAND
//
//  Created by James Yelland on 19/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit

class TitleView: UIView {
    var titleLabel: UILabel!
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        
        titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0.05 * frame.size.width, y: 0.0), size: CGSize(width: frame.size.width, height: frame.size.height)))
        titleLabel.font = UIFont.systemFont(ofSize: 46, weight: UIFontWeightBold)
        titleLabel.textColor = ljStandGreen
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let background = UIBezierPath(rect: rect)
        UIColor.white.setFill()
        background.fill()
        
        let line = UIBezierPath()
        
        line.move(to: CGPoint(x: 0.055 * frame.size.width, y: 0.8 * self.frame.size.height))
        line.addLine(to: CGPoint(x: 0.945 * frame.size.width, y: 0.8 * self.frame.size.height))
        
        UIColor.flatBlack().setStroke()
        line.lineWidth = 2
        
        line.stroke()
    }
}
