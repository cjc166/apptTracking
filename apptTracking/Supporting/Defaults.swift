//
//  Defaults.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation

extension UserDefaults {
    var userId: String? {
        get { return string(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
}
