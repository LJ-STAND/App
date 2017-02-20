//
//  HexButton.swift
//  LJ STAND
//
//  Created by James Yelland on 5/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class HexButton: UIButton {
    var text: String = ""
    
    override var frame: CGRect {
        didSet {
            super.frame = frame
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.adjustsImageWhenHighlighted = true
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath.roundedPolygonIn(rect, numberOfSides: 6, cornerRadius: 10, lineWidth: 5, rotationOffset: 0)
        self.layer.shadowPath = path.cgPath
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = rect.width / 24
        self.layer.shadowOpacity = 0.7
        
        UIColor(colorLiteralRed: 66/255, green: 66/255, blue: 66/255, alpha: 1.0).setFill()
        path.fill()
        
        path.lineWidth = 5
        UIColor.white.setStroke()
        path.stroke()
        
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        let font = UIFont.systemFont(ofSize: frame.height / 6)
        
        let attributes: [String : Any] = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : font, NSParagraphStyleAttributeName : style]
        let string = text as NSString
        
        let size = string.size(attributes: attributes)
        
        let textRect = CGRect(x: rect.origin.x + CGFloat(floorf(Float(rect.size.width - size.width) / 2.0)), y: rect.origin.y + CGFloat(floorf(Float(rect.size.height - size.height) / 2.0)), width: size.width, height: size.height)
        
        string.draw(in: textRect, withAttributes: attributes)
    }
}
