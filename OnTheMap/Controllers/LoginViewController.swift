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
    
   
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Network Request
    
    
    
    //MARK: - Button Actions
    
    @IBAction func logIn(_ sender: Any) {
        performSegue(withIdentifier: "completeLogin", sender: nil)
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    
    @IBAction func logInWithFacebook(_ sender: Any) {
        performSegue(withIdentifier: "completeLogin", sender: nil)
        
    }
    
    func handleLoginResponse(loginSuccess: Bool, error: Error?) {
        if let error = error {
            alertUserTo(error: error as NSError)
            return
        }
    }
    
    
    
    //MARK: - Login Errors User Alerts
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func alertUserTo(error: NSError) {
        let alertController = UIAlertController(title: error.domain, message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}



