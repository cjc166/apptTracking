//
//  DataManager.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    static let shared = DataManager()
    var firstVC: AppointmentListVC
    
    init() {
        firstVC = AppointmentListVC()
    }
}
