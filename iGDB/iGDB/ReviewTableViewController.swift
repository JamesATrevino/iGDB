//
//  ReviewTableViewController.swift
//  iGDB
//
//  Created by Marcus Cruz on 4/6/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

class ReviewTableViewController: UITableViewController {
    
    var gameReview:[PFObject]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameReview!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rdbID", forIndexPath: indexPath)
        
        let review = gameReview![indexPath.row]
        let username = review["username"]
        let rating = review["userRating"] as! Int
        let comment = review["userComment"]
        let starred = UIImage(named: "filledStar.png")
        
        (cell as! ReviewTableViewCell).username?.text = (username as! String)
        (cell as! ReviewTableViewCell).comment.text = comment as? String
        
        if(Int(rating) >= 1) {
            (cell as! ReviewTableViewCell).firstStar.image = starred
        }
        
        if(Int(rating) >= 2) {
            (cell as! ReviewTableViewCell).secondStar.image = starred
        }
        
        if(Int(rating) >= 3) {
            (cell as! ReviewTableViewCell).thirdStar.image = starred
        }
        
        if(Int(rating) >= 4) {
            (cell as! ReviewTableViewCell).fourthStar.image = starred
        }
        
        if(Int(rating) >= 5) {
            (cell as! ReviewTableViewCell).fifthStar.image = starred
        }
        
        
        return cell
    }
}
