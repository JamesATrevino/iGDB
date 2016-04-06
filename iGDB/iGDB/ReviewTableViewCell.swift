//
//  ReviewTableViewCell.swift
//  iGDB
//
//  Created by Melissa Mair on 4/6/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet var username: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
