//
//  HomePageVC.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation
import UIKit

class HomePageVC: UIViewController {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.logout()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func logout() {
        performSegue(withIdentifier: "logoutSegue", sender: self)
        //self.navigationcontroller?.popviewcontroller(animation: true)
        /*
        let vc: LoginPageVC  = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! LoginPageVC
        self.present(vc, animated: true, completion: {
            print("logout confirmed")
        })
        */
    }
    
}
