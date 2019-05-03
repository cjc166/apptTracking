//
//  ReplaceSegue.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation
import UIKit

class ReplaceSegue: UIStoryboardSegue {
    override func perform() {
        guard let nav = source.navigationController
            else { return }
        
        // Remove current view controller from navigation stack before segue
        let viewControllers = nav.viewControllers.filter { $0 != source }
        
        // Add destination to view controllers and perform segue
        nav.setViewControllers(viewControllers + [destination], animated: true)
    }
}
