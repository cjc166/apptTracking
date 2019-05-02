//
//  RegistrationVC.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import Foundation
import UIKit

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let user = usernameTextField.text!
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        
        var registered: Bool = Bool()
        
        let pw = API.passwordHash(username: user, password: password)
        
        if (password != confirmPassword) {
            mismatchPasswords()
        } else {
            
            API.registrationAttempt(username: user, password: pw, completionHandler: { (success, content, error) in
                registered = success
                print(registered)
                if (registered) {
                    self.registrationSuccessful()
                    self.performSegue(withIdentifier: "registerSuccessfulSegue", sender: self.registerButton)
                } else {
                    self.usernameTaken()
                }
            })
        }
    }
    
    func registrationSuccessful() {
        
        let dialogMessage = UIAlertController(title: "Success", message: "Registered!", preferredStyle: .alert)
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Okay", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func usernameTaken() {
        let dialogMessage = UIAlertController(title: "Error", message: "Username Taken", preferredStyle: .alert)
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Okay", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func mismatchPasswords() {
        let dialogMessage = UIAlertController(title: "Error", message: "Passwords don't match", preferredStyle: .alert)
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Okay", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
