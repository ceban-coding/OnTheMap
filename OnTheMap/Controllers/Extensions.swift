//
//  Extensions.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/16/21.
//


import UIKit


extension UIViewController{
    func showFailure(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}


