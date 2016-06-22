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
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let newEmail = email.text!
        if emailTest.evaluateWithObject(newEmail){
            currentUser?.email = newEmail
            currentUser?.saveInBackground()
            let alert = UIAlertController(title: "Success!", message:"Your email has been updated!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                self.accountDetailsView!.email.text = newEmail})
            self.presentViewController(alert, animated: true){}
        }
        else {
            let alert = UIAlertController(title: "Failed!", message:"Please enter a valid Email Address", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }
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
