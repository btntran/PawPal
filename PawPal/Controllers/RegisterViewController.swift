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
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Error: Email or password field is empty.")
            // Optionally, display an alert to the user
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Registration failed: \(error.localizedDescription)")
                return
            }
            
            print("Registration successful for user: \(authResult?.user.email ?? "No email")")
            self.performSegue(withIdentifier: "RegisterToHome", sender: self)
        }
    }
}
