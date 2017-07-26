//
//  MenuTableViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 9/5/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let displayNames: [String] = ["Close All", /*"Serial",*/ "TSOP", "Compass", "Light Sensors", "Robot Position", "Pixy", "Settings"]
    let viewNames: [String] = ["__CLOSE__", /*"Serial",*/ "TSOP", "Compass", "Light", "Robot Pos", "Pixy", "Settings"]
    
    init() {
        super.init(style: UITableViewStyle.grouped)
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            tableView.backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            tableView.backgroundView = blurEffectView
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
        return displayNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = displayNames[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //Close
            (UIApplication.shared.delegate as! AppDelegate).viewManager?.clearView()
            (UIApplication.shared.delegate as! AppDelegate).changeNavBarTitle("")
        } else {
            let viewName = viewNames[indexPath.row]
            (UIApplication.shared.delegate as! AppDelegate).viewManager?.clearView()
            (UIApplication.shared.delegate as! AppDelegate).viewManager?.changeView(viewName)
            (UIApplication.shared.delegate as! AppDelegate).changeNavBarTitle(viewName)

        }
        self.slideMenuController()?.closeLeft()
    }
}
