//
//  MyReviewCell.swift
//  iGDB
//
//  Created by Marcus Cruz on 4/8/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit

class MyReviewCell: UITableViewCell {

    @IBOutlet weak var gametitle: UILabel!
    @IBOutlet weak var comment: UILabel!
    //@IBOutlet weak var rating: UILabel!
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
