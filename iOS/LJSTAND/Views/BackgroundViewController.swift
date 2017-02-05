
//
//  BackgroundViewController.swift
//  LJ STAND
//
//  Created by James Yelland on 5/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class BackgroundViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = #imageLiteral(resourceName: "DarkLogo")
        imageView.contentMode = .scaleAspectFill
        
        self.view.addSubview(imageView)

        setNeedsStatusBarAppearanceUpdate()
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
