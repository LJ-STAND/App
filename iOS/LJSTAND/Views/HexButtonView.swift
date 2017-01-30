//
//  HexButtonView.swift
//  LJ STAND
//
//  Created by James Yelland on 29/1/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class HexButtonView: UIButton {
    var text: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath.roundedPolygonIn(rect: rect, numberOfSides: 6, cornerRadius: 6, lineWidth: 3, rotationOffset: 0)
            
        UIColor(colorLiteralRed: 66/255, green: 66/255, blue: 66/255, alpha: 1.0).setFill()
        path.fill()
        
        path.lineWidth = 3
        UIColor.white.setStroke()
        path.stroke()
        
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        let font = UIFont.systemFont(ofSize: 20)
        
        let attributes: [String : Any] = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : font, NSParagraphStyleAttributeName : style]
        let string = text as NSString
        
        let size = string.size(attributes: attributes)
        
        let textRect = CGRect(x: rect.origin.x + CGFloat(floorf(Float(rect.size.width - size.width) / 2.0)), y: rect.origin.y + CGFloat(floorf(Float(rect.size.height - size.height) / 2.0)), width: size.width, height: size.height)
        
        string.draw(in: textRect, withAttributes: attributes)
    }
}
