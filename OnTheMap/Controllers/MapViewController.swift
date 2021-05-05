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
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    //MARK: - Map View
    
    func setupMap() {
        mapView.mapType = .standard
        mapView.isRotateEnabled = true
    }
    
}
