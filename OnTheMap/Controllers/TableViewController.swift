//
//  TableTableViewController.swift
//  OnTheMap
//
//  Created by Ion Ceban on 4/30/21.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var mapTableView: UITableView!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UDBClient.getStudentLocation(completion: handleStudentLocationsResponse(locations:error:))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    //MARK: - Action
    
    @IBAction func logOut(_ sender: Any) {
        UDBClient.logout(completion: handleLogoutResponse(success:error:))
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        UDBClient.getStudentLocation(completion: handleStudentLocationsResponse(locations:error:))
    }
    
    
    @IBAction func addPin(_ sender: Any) {
        let addPinVC =
            storyboard?.instantiateViewController(withIdentifier: "addLocation") as! AddPinViewController
            present(addPinVC, animated: true, completion: nil)
    }
    
    // MARK: - Table view methods


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocationSaved.studentLocation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        cell.nameLabel?.text = studentLocationSaved.studentLocation[(indexPath as NSIndexPath).row].firstName + " " + studentLocationSaved.studentLocation[(indexPath as NSIndexPath).row].lastName
        cell.locationLabel?.text = studentLocationSaved.studentLocation[(indexPath as NSIndexPath).row].mediaURL
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableCell = tableView.cellForRow(at: indexPath) as! TableViewCell
        let app = UIApplication.shared
        if let toOpen = tableCell.locationLabel?.text! {
            app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
        }
    }

    
    
    func handleStudentLocationsResponse(locations: [StudentLocation], error: Error?) {
        refreshButton.isEnabled = true
        
        if error == nil {
            studentLocationSaved.studentLocation = locations
            self.tableView.reloadData()
        } else {
            showFailure(title: "No location found", message: error?.localizedDescription ?? "")
        }
    }
    
    func handleLogoutResponse(success: Bool, error: Error?) {
        if success {
            self.dismiss(animated: true, completion: nil)
        } else {
            showFailure(title: "Logout Failed", message: "An Error has occured. Try again.")
        }
    }
    
    
}
