//
//  UpdateUserInfoViewController.swift
//  iGDB
//
//  Created by Jason Ngo on 5/4/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

class UpdateUserInfoViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    var accountDetailsView: AccountDetailsViewController? = nil
    
    @IBAction func update(sender: AnyObject) {
        let currentUser = PFUser.currentUser()
        let newEmail = email.text!
        currentUser?.email = newEmail
        currentUser?.saveInBackground()
        let alert = UIAlertController(title: "Success!", message:"Your email has been updated!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
            self.accountDetailsView!.email.text = newEmail})
        self.presentViewController(alert, animated: true){}
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
