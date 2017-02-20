//
//  WindowManagerTableViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 5/2/17.
//  Copyright © 2017 Lachlan Grant. All rights reserved.
//

import UIKit

class WindowManagerTableViewController: UITableViewController {
    
    let viewControllers = ["Serial", "Light", "Compass", "TSOP", "Design"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = viewControllers[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWindow"), object: viewControllers[indexPath.row])
    }
}
