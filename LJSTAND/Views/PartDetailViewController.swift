//
//  PartDetailViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 19/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import SafariServices

class PartDetailViewController: UIViewController {
    var index: Int!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var supplierLabel: UILabel!
    @IBOutlet weak var vendorPartLabel: UILabel!
    @IBOutlet weak var totalQtyLabel: UILabel!
    @IBOutlet weak var sparesLabel: UILabel!
    @IBOutlet weak var priceInORGCurrencyLabel: UILabel!
    @IBOutlet weak var priceAudLabel: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var weightPerItem: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var totalWeight: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var productButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tintNavigationController()
        updateLabel()
    }
    
    func updateLabel() {
        let part = PartParser.shared.parts[index]
        
        self.title = trimString(part.item)
        descriptionLabel.text = trimString(part.description)
        supplierLabel.text = "Supplier: \(trimString(part.supplier))"
        vendorPartLabel.text = "Part #: \(trimString(part.vendorPartNumber))"
        totalQtyLabel.text = "Quantity: \(trimString(part.totalQty))"
        sparesLabel.text = "Spares: \(trimString(part.spares))"
        priceInORGCurrencyLabel.text = "\(trimString(part.priceInOrgCurrency)) \(trimString(part.currency))"
        priceAudLabel.text = trimString(part.priceInAUD)
        totalPrice.text = trimString(part.totalPrice)
        weightPerItem.text = "\(trimString(part.weightPerItem))g/part"
        qtyLabel.text = "# per robot: \(trimString(part.qtyPerRobot))"
        totalWeight.text = "Total Weight: \(trimString(part.totalWeight))"
        notesTextView.text = trimString(part.notes)
        
        if (part.link == "") {
            productButton.isEnabled = false
        }
    }
    
    @IBAction func openProductPageAction(_ sender: Any) {
        let url = URL(string: trimString(PartParser.shared.parts[index].link))
        if url != nil {
            let safariVC = SFSafariViewController(url: url!, entersReaderIfAvailable: false)
            self.present(safariVC, animated: true, completion: nil)
        }
        
    }
    
    func trimString(_ str: String) -> String {
        return str.replacingOccurrences(of: "\"", with: "")
    }
}
