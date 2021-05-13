//
//  ViewController.swift
//  OnTheMap
//
//  Created by Ion Ceban on 4/29/21.
//

import UIKit
import Foundation

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInFacebookButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var keyboardIsVisible = false
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.activityIndicator.isHidden = true
        self.activityIndicator.hidesWhenStopped = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotification()
    }
    
    
    //MARK: - Button Actions
    
    @IBAction func logIn(_ sender: Any) {
        fieldsChecker()
        setLoggingIn(true)
        UDBClient.login(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: handleLoginResponse(loginSuccess:error:))
       
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func logInWithFacebook(_ sender: Any) {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    
    //MARK: - function for request
    
    
    func handleLoginResponse(loginSuccess: Bool, error: Error?) {
        setLoggingIn(false)
        if !loginSuccess {
            DispatchQueue.main.async {
                let invalidAccess = UIAlertController(title: "Invalid Access", message: "Login credentials are incorrect", preferredStyle: .alert)
                invalidAccess.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    return
                }))
                self.present(invalidAccess, animated: true, completion: nil)
            }
        }
        if loginSuccess {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completedLogin", sender: nil)
            }
        } else {
            showLoginFailure(title: "Login Failed", message: error?.localizedDescription ?? "")
        }
    }
    
    
    func setLoggingIn(_ loggingIn: Bool) {
        DispatchQueue.main.async {
            if loggingIn {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
            self.emailTextField.isEnabled = !loggingIn
            self.passwordTextField.isEnabled = !loggingIn
            self.logInButton.isEnabled = !loggingIn
        }
    }
    
    
    //MARK: - Login Errors User Alerts
    
    func showLoginFailure(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
   
    
    func fieldsChecker() {
       if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!  {
           DispatchQueue.main.async {
               let alert = UIAlertController(title: "Credentials were not filled in", message: "Please fill both email and password", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               self.present(alert, animated: true, completion: nil)
           }
        

       } else {
           setLoggingIn(true)
       }
   }
    
    
    //MARK: - Function for keyboard
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !keyboardIsVisible && (emailTextField.isEditing || passwordTextField.isEditing) {
            view.frame.origin.y -= logInButton.frame.height
            keyboardIsVisible = true
            }
        }
    

   @objc func keyboardWillHide(_ notification:Notification) {
      if keyboardIsVisible {
          view.frame.origin.y += logInButton.frame.height
          keyboardIsVisible = false
       }
    }
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Text field delegate functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}






