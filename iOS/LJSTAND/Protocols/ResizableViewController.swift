//
//  ResizableViewController.swift
//  LJ STAND
//
//  Created by James Yelland on 5/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ResizableViewController {
     @objc optional func windowWasResized()
}
