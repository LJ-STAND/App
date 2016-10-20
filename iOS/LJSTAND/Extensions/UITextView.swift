//
//  UITextView.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 18/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit

extension UITextView {
    func scrollToBotom() {
        let range = NSMakeRange(text.characters.count - 1, 1);
        scrollRangeToVisible(range);
    }
}
