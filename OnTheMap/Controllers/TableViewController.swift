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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    //MARK: - Action
    
    @IBAction func logOut(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        
    }
    
    
    @IBAction func addPin(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
}
