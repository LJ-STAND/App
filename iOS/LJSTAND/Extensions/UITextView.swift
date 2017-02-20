//
//  UITextView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 18/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit

extension UITextView {
    func scrollToBottom() {
        let range = NSMakeRange(text.characters.count - 1, 0);
        scrollRangeToVisible(range);
    }
}
