//
//  ReviewViewController.swift
//  iGDB
//
//  Created by Marcus Cruz on 4/4/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

class ReviewViewController: UIViewController, UITextFieldDelegate {

    var game:PFObject?
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var submitReview: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = game!["name"]
        self.title = name as? String
        gameLabel.text = game!["name"] as? String
        
        self.commentField.delegate = self
        
        let url = game!["image"] as? String
        if url != "not set"
        {
            let checkedUrl = NSURL(string: url!)
            imageView.contentMode = .ScaleAspectFit
            downloadImage(checkedUrl!)
        }

        // Do any additional setup after loading the view.
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.commentField.resignFirstResponder()
        super.touchesBegan(touches, withEvent: event)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
//    func sendRating() {
//        if indexPath.row == 3
//        {
//            // Send a request to log out a user
//            PFUser.logOut()
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("loginNav")
//                self.presentViewController(viewController, animated: true, completion: nil)
//            })
//            
//        }
//    }

    @IBAction func loginPressed(sender: AnyObject){
        
        let userID = String(PFUser.currentUser())
        let gameID = String(game!["objectId"] as? String)
        let userRating = 0;
        let userComment = String(self.commentField.text!);
        
        // Validate the text fields
        /*if userComment.characters.count < 5
        {
            let alert = UIAlertController(title: "Oops!", message:"You forgot to add a review", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        }*/
        
        if true {
            //do nothing
        }
            
        else
        {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send the user rating to the server
            //PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                
            // Stop the spinner
            spinner.stopAnimating()
                
            if (true)
            {
                    /*dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mainNav") as! UINavigationController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })*/
                    
            } else {
                    let alert = UIAlertController(title: "Oops!", message: "Unknown Error", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}}
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
