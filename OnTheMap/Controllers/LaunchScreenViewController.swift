//
//  LaunchScreenViewController.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/4/21.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemGreen
    }

    
    @IBAction func getStartedButton(_ sender: Any) {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.performSegue(withIdentifier: "loginView", sender: self)
        })
    }
    
   
    
}
