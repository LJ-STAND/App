//
//  PartsListTableViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 19/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import MKKit

class PartsListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.flatBlack()]

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parts.parts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = parts.parts[indexPath.row]
        
        cell.textLabel?.text = item.item.replacingOccurrences(of: "\"", with: "")
        cell.detailTextLabel?.text = item.description.replacingOccurrences(of: "\"", with: "")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = getViewController(sbName: "Main", vcName: "partDetail") as! PartDetailViewController
        view.index = indexPath.row
        self.navigationController?.pushViewController(view, animated: true)
    }
}
