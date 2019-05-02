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
        if (/* login condition */ usernameTextField.text! == "abc") {
            performSegue(withIdentifier: "loginSegue", sender: self)
        } else {
            loginError()
        }
       /* let vc: HomePageVC = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") as! HomePageVC
        self.present(vc, animated: true, completion: {
            print("login successful")
        }) */
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
    }
    
    func loginError() {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Invalid Credentials", preferredStyle: .alert)
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Okay", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func logoutSegue(segue:UIStoryboardSegue) {
        
    }
    
}

