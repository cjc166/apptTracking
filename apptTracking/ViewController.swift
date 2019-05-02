//
//  ViewController.swift
//  apptTracking
//
//  Created by Caleb Cain on 5/2/19.
//  Copyright © 2019 Caleb. All rights reserved.
//

import UIKit

class LoginPageVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIBarButtonItem!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        DispatchQueue.main.async {
            let user = self.usernameTextField.text!
            var pw = self.passwordTextField.text!
            
            pw = API.passwordHash(username: user, password: pw)
            
            var loggedIn: Bool = Bool()

            API.loginAttempt(username: user, password: pw, completionHandler: { (success, content, error) in
                loggedIn = success
                print(loggedIn)
                
                if (loggedIn) {
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                } else {
                    self.loginError()
                }
            })
        }
    }
    
    func loginError() {
        let dialogMessage = UIAlertController(title: "Error", message: "Invalid Credentials", preferredStyle: .alert)
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Okay", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
    }
    
    @IBAction func logoutSegue(segue:UIStoryboardSegue) {
    }
    
}

