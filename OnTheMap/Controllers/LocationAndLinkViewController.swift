//
//  LocationAndLinkViewController.swift
//  OnTheMap
//
//  Created by Ion Ceban on 5/3/21.
//

import UIKit
import MapKit

class LocationAndLinkViewController: UIViewController {
    
    
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancel(_ sender: Any) {
        
    }
    
    
    @IBAction func submit(_ sender: Any) {
        
    }
    
}
