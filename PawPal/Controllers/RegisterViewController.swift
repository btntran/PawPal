//
//  RegisterViewController.swift
//  PawPal
//
//  Created by Khang Nguyen on 10/12/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password){authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                    //Need to further improve by display the error
                    //....
                }else{
                    //Navigate to homepage
                    self.performSegue(withIdentifier: "RegisterToHome", sender: self)
                }
            }
        }
    }
    
}
