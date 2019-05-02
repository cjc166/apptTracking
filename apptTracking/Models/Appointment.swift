//
//  Appointment.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation
import Alamofire

public struct Appointment {
    
    public enum Format {
        case checkup
        case firsttime
        case followup
    }
    
    let phoneNumber: String
    let address: String
    let type: Format
    let time: String
    let office: String
    let date: String
    
}

/*
typealias GroceryList = [GroceryItem]

extension Collection where Element == GroceryItem {
    
    public func total() -> Double {
        return reduce(0, { total, item in
            return total + item.price
        })
    }
    
}
*/
