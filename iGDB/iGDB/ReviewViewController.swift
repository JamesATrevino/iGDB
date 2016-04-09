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
    @IBOutlet weak var mywidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.directionalLockEnabled = true
        
        self.title = "Write A Review" // as? String
        gameLabel.text = game!["name"] as? String
        
        let convertedDate = game!.updatedAt
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        let date2 = dateFormatter.stringFromDate((convertedDate)!)
        
        self.commentField.delegate = self
        self.mywidth.constant = self.view.bounds.size.width
        self.dateLabel.text = date2 //as? String
        
        let url = game!["image"] as? String
        if url != "not set"
        {
            let checkedUrl = NSURL(string: url!)
            imageView.contentMode = .ScaleAspectFit
            downloadImage(checkedUrl!)
        }
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
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.commentField.resignFirstResponder()
        super.touchesBegan(touches, withEvent: event)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 200)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 200)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    
    @IBAction func stepperAction(sender: AnyObject) {
        userScore.text = "\(Int(stepper.value))"
        
        if(Int(stepper.value) >= 1) {
            star1.setImage(UIImage(named: "filledStar.png"), forState: .Normal)
        } else {
            star1.setImage(UIImage(named: "emptyStar.png"), forState: .Normal)
        }
        
        if(Int(stepper.value) >= 2) {
            star2.setImage(UIImage(named: "filledStar.png"), forState: .Normal)
        } else {
            star2.setImage(UIImage(named: "emptyStar.png"), forState: .Normal)
        }
        
        if(Int(stepper.value) >= 3) {
            star3.setImage(UIImage(named: "filledStar.png"), forState: .Normal)
        } else {
            star3.setImage(UIImage(named: "emptyStar.png"), forState: .Normal)
        }
        
        if(Int(stepper.value) >= 4) {
            star4.setImage(UIImage(named: "filledStar.png"), forState: .Normal)
        } else {
            star4.setImage(UIImage(named: "emptyStar.png"), forState: .Normal)
        }
        
        if(Int(stepper.value) >= 5) {
            star5.setImage(UIImage(named: "filledStar.png"), forState: .Normal)
        } else {
            star5.setImage(UIImage(named: "emptyStar.png"), forState: .Normal)
        }
    }

    @IBAction func submitPressed(sender: AnyObject){
        
        let myInt:Int? = Int(userScore.text!)
        
        let gameScore = PFObject(className:"UserRatings")
        gameScore["userRating"] = myInt //TODO: Remove hardcoded rating and pull from view
        gameScore["userComment"] = String(self.commentField.text!)
        gameScore["gameID"] = game?.objectId
        gameScore["userID"] = (PFUser.currentUser())!.objectId
        gameScore["gamename"] = game!["name"]
        gameScore["username"] = PFUser.currentUser()!.username
        
        gameScore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                let alert = UIAlertController(title: "Success!", message:
                    "Your review has been submitted. To return to the game entry, use the navigation bar.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                    print("before ok clicked \(reviewsList.count)")
                    reviewsList.removeAll()
                    print("after removeAll \(reviewsList.count)")
                    let r_query = PFQuery(className: "UserRatings")
                    r_query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                        if error == nil
                        {
                            for object in objects! {
                                reviewsList.append(object)
                            }
                        }
                        
                        else
                        {
                            print(error)
                        }
                    }
                    print("after querying again \(reviewsList.count)")})
                self.presentViewController(alert, animated: true){}
            } else {
                let alert = UIAlertController(title: "Oops!", message: "There was an error sending your review. Please try again.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                self.presentViewController(alert, animated: true){}
            }
        }
        
    }
}
