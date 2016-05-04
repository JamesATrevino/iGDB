//
//  AccountDetailsViewController.swift
//  iGDB
//
//  Created by Jason Ngo on 3/23/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

class AccountDetailsViewController: UIViewController {

    var gameReview:[PFObject] = [PFObject]()
    
    @IBOutlet var username: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let currentUser = PFUser.currentUser()
        let name = currentUser?.username
        username.text = name
        let currentEmail = currentUser?.email
        if currentEmail == nil {
        email.text = "You haven't added an email address." //PFUser.currentUser()!.email
        }
        else {
            email.text = currentEmail
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "myReviews" {
            gameReview.removeAll()
            
            for games in reviewsList {
                if games["userID"] as? String == (PFUser.currentUser())!.objectId
                {
                    self.gameReview.append(games)
                }
            }
            
            let userReviews:MyReviewsController = (segue.destinationViewController as? MyReviewsController)!
            userReviews.gameReview = self.gameReview
        }
        if segue.identifier == "update" {
            let updateViewVC:UpdateUserInfoViewController = (segue.destinationViewController as? UpdateUserInfoViewController)!
            updateViewVC.accountDetailsView = self
        }
    }

}
