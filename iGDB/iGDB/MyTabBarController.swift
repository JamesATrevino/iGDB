//
//  MyTabBarController.swift
//  iGDB
//
//  Created by James Trevino on 3/22/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

var gamesList:[PFObject] = [PFObject]()
var reviewsList:[PFObject] = [PFObject]()
var commentsList:[PFObject] = [PFObject]()

class MyTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let query = PFQuery(className: "Games")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects! {
                    gamesList.append(object)
                }
            } else {
                print(error)
            }
        }
        
        let r_query = PFQuery(className: "UserRatings")
        
        r_query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects! {
                    reviewsList.append(object)
                }
            } else {
                print(error)
            }
        }
        
        let c_query = PFQuery(className: "gameComments")
        c_query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects! {
                    commentsList.append(object)
                }
            } else {
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
