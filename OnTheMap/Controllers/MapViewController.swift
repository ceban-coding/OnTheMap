//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Ion Ceban on 4/30/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var logOut: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UDBClient.getStudentLocation(completion: handleStudentLocationsResponse(locations:error:))
        mapView.delegate = self
        
    }
    
    
    //MARK: - Action
    
    
    @IBAction func logOutAction(_ sender: Any) {
        UDBClient.logout(completion: handleLogoutResponse(success:error:))
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        UDBClient.getStudentLocation(completion: handleStudentLocationsResponse(locations:error:))
    }
    
    
    @IBAction func addPinLocation(_ sender: Any) {
        let addPinVC =
            storyboard?.instantiateViewController(withIdentifier: "addLocation") as! AddPinViewController
            present(addPinVC, animated: true, completion: nil)
    }
    //MARK: - Map View
    
    func setupMap() {
        mapView.mapType = .standard
        mapView.isRotateEnabled = true
    }
    
    
    //MARK: - Map methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    func showMapAnnotations(_ locations: [StudentLocation]) {
        var annotations = [MKPointAnnotation]()
        
        for location in locations {
            let latitude = CLLocationDegrees(location.latitude)
            let longitude = CLLocationDegrees(location.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let firstName = location.firstName
            let lastName = location.lastName
            let mediaURL = location.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(firstName) \(lastName)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        self.mapView.addAnnotations(annotations)
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                UIApplication.shared.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    //MARK: - Data methods
    
    func handleStudentLocationsResponse(locations: [StudentLocation], error: Error?) {
        
        
        if error == nil {
            if self.mapView.annotations.count > 0 {
                self.mapView.removeAnnotations(self.mapView.annotations)
            }
            appDelegate.studentLocations = locations
            showMapAnnotations(locations)
        } else {
            showFailure(title: "Get Student Locations Failed", message: error?.localizedDescription ?? "")
        }
    }
    
    func handleLogoutResponse(success: Bool, error: Error?) {
        if success {
            self.dismiss(animated: true, completion: nil)
        } else {
            showFailure(title: "Logout Failed", message: error?.localizedDescription ?? "")
        }
    }
    
    func showFailure(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
