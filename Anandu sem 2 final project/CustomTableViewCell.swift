//
//  CustomTableViewCell.swift
//  Anandu sem 2 final project
//
//  Created by Nandu on 2021-09-30.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet public weak var nameText: UILabel!
 
    @IBOutlet public weak var countryText: UILabel!

    
    @IBOutlet public weak var userImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
