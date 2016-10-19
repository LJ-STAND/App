//
//  DesignTableViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 19/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit

class DesignTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath[0] == 1 && indexPath[1] == 1 {
            let view = getViewController(sbName: "Main", vcName: "render1")
//            view.url = URL(fileURLWithPath: Bundle.main.path(forResource: "Render 1", ofType: "bmp")!)
//            view.title = "Render 1"
//            
            self.navigationController?.pushViewController(view, animated: true)
        }
        
        if indexPath[0] == 2 {
            let view = getViewController(sbName: "Main", vcName: "webView") as! WebViewController
            switch indexPath[1] {
            case 0:
                view.url = URL(fileURLWithPath: Bundle.main.path(forResource: "Fuse", ofType: "PDF")!)
                view.navTitle = "Fuse"
            case 1:
                view.url = URL(fileURLWithPath: Bundle.main.path(forResource: "LM", ofType: "pdf")!)
                view.navTitle = "LM1084"
            case 2:
                view.url = URL(fileURLWithPath: Bundle.main.path(forResource: "Photo", ofType: "pdf")!)
                view.navTitle = "PhotoTransistor"
            case 3:
                view.url = URL(fileURLWithPath: Bundle.main.path(forResource: "Regulator", ofType: "pdf")!)
                view.navTitle = "Switching Regulator"
            case 4:
                view.url = URL(fileURLWithPath: Bundle.main.path(forResource: "MotorCtrl", ofType: "pdf")!)
                view.navTitle = "Motor Controller"
            case 5:
                view.url = URL(fileURLWithPath: Bundle.main.path(forResource: "TSOP", ofType: "pdf")!)
                view.navTitle = "TSOP"
            default:
                log.error("Um wat")
            }
            view.title = view.navTitle
            self.navigationController?.pushViewController(view, animated: true)
            
        }
    }
}
