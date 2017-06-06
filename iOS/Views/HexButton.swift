//
//  HexButton.swift
//  LJ STAND
//
//  Created by James Yelland on 5/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

@IBDesignable
class HexButton: UIButton {
    @IBInspectable var text: String = ""
    var viewName: String = ""
    
    override var frame: CGRect {
        didSet {
            super.frame = frame
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.adjustsImageWhenHighlighted = true
        self.backgroundColor = UIColor.clear
        
        self.titleLabel?.textColor = .clear
        self.titleLabel?.text = ""
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath.roundedPolygonIn(rect, numberOfSides: 6, cornerRadius: 0, lineWidth: 5, rotationOffset: 0)
        
        UIColor(colorLiteralRed: 66/255, green: 66/255, blue: 66/255, alpha: 0.5).setFill()
        
        path.lineWidth = 1
        UIColor.white.setStroke()
        path.stroke()
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        let font = UIFont(name: "Dosis-Light", size: frame.height / 9)!
        
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : font, NSAttributedStringKey.paragraphStyle : style]
        let string = text as NSString
        
        let size = string.size(withAttributes: attributes)
        
        let textRect = CGRect(x: rect.origin.x + CGFloat(floorf(Float(rect.size.width - size.width) / 2.0)), y: rect.origin.y + CGFloat(floorf(Float(rect.size.height - size.height) / 2.0)), width: size.width, height: size.height)
        
        string.draw(in: textRect, withAttributes: attributes)
    }
}
