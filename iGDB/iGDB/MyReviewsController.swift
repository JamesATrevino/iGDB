//
//  MyReviewsController.swift
//  iGDB
//
//  Created by Marcus Cruz on 4/8/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

class MyReviewsController: UITableViewController {

    var gameReview:[PFObject]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameReview!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myrb", forIndexPath: indexPath)
        
        let review = gameReview![indexPath.row]
        let gamename = review["gamename"]
        let rating = review["userRating"] as! Int
        let comment = review["userComment"]
        let starred = UIImage(named: "filledStar.png")
        
        if(Int(rating) >= 1) {
          (cell as! MyReviewCell).firstStar.image = starred
        }
        
        if(Int(rating) >= 2) {
            (cell as! MyReviewCell).secondStar.image = starred
        }
        
        if(Int(rating) >= 3) {
            (cell as! MyReviewCell).thirdStar.image = starred
        }
        
        if(Int(rating) >= 4) {
            (cell as! MyReviewCell).fourthStar.image = starred
        }
        
        if(Int(rating) >= 5) {
            (cell as! MyReviewCell).fifthStar.image = starred
        }
        
        (cell as! MyReviewCell).gametitle?.text = (gamename as! String)
        (cell as! MyReviewCell).comment.text = comment as? String
        
        //(cell as! MyReviewCell).rating?.text = ("\(rating)")
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
