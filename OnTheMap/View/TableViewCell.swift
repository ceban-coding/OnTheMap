//
//  TableViewCell.swift
//  OnTheMap
//
//  Created by Ion Ceban on 4/30/21.
//

import UIKit

class TableViewCell: UITableViewCell {

  
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
