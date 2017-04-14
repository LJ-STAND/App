//
//  WindowView.swift
//  LJ STAND
//
//  Created by James Yelland on 8/4/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

let headerHeight: CGFloat = 44.0
let contentPadding: CGFloat = 15.0

class WindowView: UIView {
    var contentView: UIView = UIView() {
        didSet {
            addSubview(contentView)
            resize()
        }
    }
    
    var title: String = "" {
        didSet {
            titleView.text = title
        }
    }
    
    var titleView: CenteredTextView = CenteredTextView()
    var lineView: UIView = UIView()
    
    override var frame: CGRect {
        didSet {
            super.frame = frame
            setNeedsDisplay()
            resize()
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
    
    private func commonInit() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        titleView = CenteredTextView()
        titleView.text = title
        titleView.textSize = headerHeight * 0.7
        titleView.horizontalAlignment = NSTextAlignment.left
        titleView.backgroundColor = UIColor.clear
        
        lineView = UIView()
        lineView.backgroundColor = UIColor.white
        
        addSubview(lineView)
        addSubview(titleView)
        
        resize()
    }
    
    func resize() {
        let lineWidth = frame.width - (contentPadding * 2)
        let lineX = (frame.width - lineWidth) / 2
        
        titleView.frame = CGRect(x: lineX, y: 0.0, width: lineWidth, height: headerHeight)
        lineView.frame = CGRect(x: lineX, y: headerHeight, width: lineWidth, height: 1)
        contentView.frame = CGRect(x: contentPadding, y: headerHeight + contentPadding, width: frame.width - contentPadding * 2, height: frame.height - headerHeight - contentPadding * 2)
    }
}
