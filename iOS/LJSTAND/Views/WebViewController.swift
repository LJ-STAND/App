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
import WebKit

class WebViewController: UIViewController {
    var url: URL! = URL(string: "https://google.com")
    var navTitle: String! = ""
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tintNavigationController()
        
        webView = WKWebView(frame: self.view.frame)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsLinkPreview = true
        self.view.addSubview(webView)
        
        self.view.addConstraint(NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: webView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: webView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0))
        
        self.view.layoutIfNeeded()
        
        loadWeb()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadWeb() {
        let request = URLRequest(url: url)
        webView.load(request)
        
        self.navigationController?.title = navTitle
    }
}
