//
//  WebViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 19/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit
import Chameleon

class WebViewController: UIViewController {
    var url: URL! = URL(string: "https://google.com")
    var navTitle: String! = ""
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadWeb()
    }
    
    func loadWeb() {
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
        self.navigationController?.title = navTitle
    }
}
