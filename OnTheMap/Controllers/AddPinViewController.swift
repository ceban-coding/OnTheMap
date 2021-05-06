//
//  AddPinViewController.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/3/21.
//

import UIKit

class AddPinViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

   

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func findLocation(_ sender: Any) {
        
    }
}
