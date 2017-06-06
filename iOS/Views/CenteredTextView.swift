//
//  CenteredTextView.swift
//  LJ STAND
//
//  Created by James Yelland on 8/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class CenteredTextView: UIView {
    var text: String = ""
    var textSize: CGFloat = 0.0
    var horizontalAlignment: NSTextAlignment = NSTextAlignment.center
    
    override var frame: CGRect {
        didSet {
            super.frame = frame
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        let font = UIFont(name: "Dosis-Light", size: textSize)!
        
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : font, NSAttributedStringKey.paragraphStyle : style]
        let string = text as NSString
        
        let size = string.size(withAttributes: attributes)
        
        var textRect: CGRect
        
        if horizontalAlignment == NSTextAlignment.left {
            textRect = CGRect(x: rect.origin.x, y: rect.origin.y + CGFloat(floorf(Float(rect.size.height - size.height) / 2.0)), width: size.width, height: size.height)
        } else if horizontalAlignment == NSTextAlignment.right {
            textRect = CGRect(x: rect.origin.x + (rect.size.width - size.width), y: rect.origin.y + CGFloat(floorf(Float(rect.size.height - size.height) / 2.0)), width: size.width, height: size.height)
        } else {
            textRect = CGRect(x: rect.origin.x + CGFloat(floorf(Float(rect.size.width - size.width) / 2.0)), y: rect.origin.y + CGFloat(floorf(Float(rect.size.height - size.height) / 2.0)), width: size.width, height: size.height)
        }
        
        string.draw(in: textRect, withAttributes: attributes)
    }
        
    func textWidth() -> CGFloat {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        let font = UIFont(name: "Dosis-Light", size: textSize)!
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : font, NSAttributedStringKey.paragraphStyle : style]
        let string = text as NSString
        
        let size = string.size(withAttributes: attributes)
        
        return size.width
    }
}
