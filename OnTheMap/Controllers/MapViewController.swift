//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Ion Ceban on 4/30/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var logOut: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: - Action
    
    
    @IBAction func logOutAction(_ sender: Any) {
        
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        
    }
    
    
    @IBAction func addPinLocation(_ sender: Any) {
        
    }
    //MARK: - Map View
    
    func setupMap() {
        mapView.mapType = .standard
        mapView.isRotateEnabled = true
    }
    
}
