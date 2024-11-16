//
//  LoginViewController.swift
//  PawPal
//
//  Created by Khang Nguyen on 10/12/24.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Error: Email or password field is empty.")
            // Optionally, display an alert to the user
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Email/password login failed: \(error.localizedDescription)")
                return
            }
            
            print("Login successful for user: \(authResult?.user.email ?? "No email")")
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }
    }
    
    @IBAction func googleLoginPressed(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Error: Firebase clientID is missing.")
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Google sign-in error: \(error.localizedDescription)")
                return
            }
            
            guard let idToken = result?.user.idToken?.tokenString,
                  let accessToken = result?.user.accessToken.tokenString else {
                print("Google sign-in failed: Missing tokens.")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Google sign-in failed: \(error.localizedDescription)")
                    return
                }
                
                print("Google login successful for user: \(authResult?.user.email ?? "No email")")
                self.performSegue(withIdentifier: "LoginToHome", sender: self)
            }
        }
    }
}
