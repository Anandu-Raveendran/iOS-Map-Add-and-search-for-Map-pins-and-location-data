//
//  EmptyTableViewCell.swift
//  Anandu sem 2 final project
//
//  Created by Nandu on 2021-10-01.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
