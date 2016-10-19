//
//  PartParser.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 19/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import Foundation

class PartParser {
    var parts: [Part]
    var errored: Bool
    
    init() {
        parts = []
        errored = false
        
        getData()
    }
    
    private func getData() {
        do {
            let filePath = Bundle.main.path(forResource: "parts", ofType: "csv")!
            let fileURL = URL(fileURLWithPath: filePath)
            let data = try String(contentsOf: fileURL)
            
            let delimiter = ","
            let lines = data.components(separatedBy: CharacterSet.newlines) as [String]
            var tempParts: [Part] = []
            for i in 1...lines.count - 1 {
                let thisLine = lines[i]
                let lineComps = thisLine.components(separatedBy: delimiter)
                
                let item = Part()
                for i in 0...lineComps.count - 1 {
                    let detail = lineComps[i]
                    
                    switch i {
                    case 0:
                        item.item = detail
                    case 1:
                        item.description = detail
                    case 2:
                        item.supplier = detail
                    case 3:
                        item.vendorPartNumber = detail
                    case 4:
                        item.totalQty = detail
                    case 5:
                        item.spares = detail
                    case 6:
                        item.priceInOrgCurrency = detail
                    case 7:
                        item.currency = detail
                    case 8:
                        item.priceInAUD = detail
                    case 9:
                        item.totalPrice = detail
                    case 10:
                        item.link = detail
                    case 11:
                        item.weightPerItem = detail
                    case 12:
                        item.qtyPerRobot = detail
                    case 13:
                        item.totalWeight = detail
                    case 14:
                        item.notes = detail
                    default:
                        break
                    }
                }
                tempParts.append(item)
            }
            parts = tempParts
            errored = false
            
        } catch {
            log.error("CSV Parsing Error")
            errored = true
        }
    }
}
