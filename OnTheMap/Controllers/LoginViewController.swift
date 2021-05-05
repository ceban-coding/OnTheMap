//
//  ViewController.swift
//  OnTheMap
//
//  Created by Ion Ceban on 4/29/21.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInFacebookButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    
    @IBAction func logIn(_ sender: Any) {
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
    }
    
    
    @IBAction func logInWithFacebook(_ sender: Any) {
        
    }
    
}

