//
//  TableViewCell.swift
//  OnTheMap
//
//  Created by Ion Ceban on 4/30/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableCell: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
