//
//  RegistrationViewController.swift
//  iGDB
//
//  Created by James Trevino on 3/22/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

class RegistrationViewController: UIViewController {

    @IBOutlet weak var confirmPwTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerBtnPressed(sender: AnyObject){
        let username = String(self.nameTextField.text!)
        let password = String(self.passwordTextField.text!)
        let confirmPassword = String(self.confirmPwTextField.text!)
        print(username.characters.count)
        // Validate the text fields
        if username.characters.count < 5
        {
            let alert = UIAlertController(title: "Oops!", message:"Username must be greater than 5 characters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }
        else if password.characters.count < 8
        {
            let alert = UIAlertController(title: "Oops!", message:"Password must be greater than 5 characters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
        }
        else if password != confirmPassword
        {
            let alert = UIAlertController(title: "Oops!", message:"Passwords must match", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }
        else
        {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil)
                {
                    let alert = UIAlertController(title: "Oops!", message: "\(error)", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                }
                else
                {
                    let alert = UIAlertController(title: "Success", message:"Signup Successful", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:MyTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBarController") as! MyTabBarController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            })
        }
    }
    
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
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
