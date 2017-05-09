//
//  MenuTableViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 9/5/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    init() {
        super.init(style: UITableViewStyle.grouped)
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            tableView.backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            tableView.backgroundView = blurEffectView
            
//            //if inside a popover
//            if let popover = navigationController?.popoverPresentationController {
//                popover.backgroundColor = .clear
//            }
            
            //if you want translucent vibrant table view separator lines
//            tableView.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
            tableView.separatorStyle = .none
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Serial"
            
        case 1:
            cell.textLabel?.text = "TSOP"
            
        case 2:
            cell.textLabel?.text = "Compass"
            
        case 3:
            cell.textLabel?.text = "Light Sensor"
            
        case 4:
            cell.textLabel?.text = "Robot Position"
            
        case 5:
            cell.textLabel?.text = "Settings"
        default:
            cell.textLabel?.text = "Logic Error"
        }
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var viewName = ""
        switch indexPath.row {
        case 0:
            viewName = "Serial"
        
        case 1:
           viewName = "TSOP"
            
        case 2:
            viewName = "Compass"
            
        case 3:
            viewName = "Light"
            
        case 4:
            viewName = "Robot Pos"
            
        case 5 :
            viewName = "Settings"
            
        default:
            break
        }
        (UIApplication.shared.delegate as! AppDelegate).viewManager?.clearView()
        (UIApplication.shared.delegate as! AppDelegate).viewManager?.changeView(viewName)
        self.slideMenuController()?.closeLeft()
    }
}
