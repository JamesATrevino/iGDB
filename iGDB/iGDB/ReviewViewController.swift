//
//  ReviewViewController.swift
//  iGDB
//
//  Created by Marcus Cruz on 4/4/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var submitReview: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentField.delegate = self
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
