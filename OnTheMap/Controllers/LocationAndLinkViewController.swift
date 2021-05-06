//
//  LocationAndLinkViewController.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/3/21.
//

import UIKit
import MapKit

class LocationAndLinkViewController: UIViewController {
    

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - Actions
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submit(_ sender: Any) {
        
    }
    
}
