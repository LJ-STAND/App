//
//  PartDetailViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 19/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit

class PartDetailViewController: UIViewController {
    var index: Int!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var supplierLabel: UILabel!
    @IBOutlet weak var vendorPartLabel: UILabel!
    @IBOutlet weak var totalQtyLabel: UILabel!
    @IBOutlet weak var sparesLabel: UILabel!
    @IBOutlet weak var priceInORGCurrencyLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceAudLabel: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var weightPerItem: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var totalWeight: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateLabel()
    }
    
    func updateLabel() {
        let part = parts.parts[index]
        
        titleLabel.text = part.item
        descriptionLabel.text = part.description
        supplierLabel.text = part.supplier
        vendorPartLabel.text = part.vendorPartNumber
        totalQtyLabel.text = part.totalQty
        sparesLabel.text = part.spares
        priceInORGCurrencyLabel.text = part.priceInOrgCurrency
        currencyLabel.text = part.currency
        priceAudLabel.text = part.priceInAUD
        totalPrice.text = part.totalPrice
        linkLabel.text = part.link
        weightPerItem.text = part.weightPerItem
        qtyLabel.text = part.qtyPerRobot
        totalWeight.text = part.totalWeight
    }
}
