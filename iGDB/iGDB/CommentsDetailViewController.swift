//
//  CommentsDetailViewController.swift
//  iGDB
//
//  Created by James Trevino on 4/6/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

class CommentsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var game:PFObject?
    var gameComments:[PFObject] = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let name = game!["name"]
        self.headerLabel.text = String(name) + " comments"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "commentCell")
        for item in commentsList
        {
            if(String(item["gameId"]) == String(self.game!["name"]))
            {
                self.gameComments.append(item)
            }
        }
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameComments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
        let myFont = UIFont(name: "Helvetica", size:17.0)
        let commentObj = gameComments[indexPath.row]
        let comment = commentObj["comment"] as! String
        let creator = commentObj["creator"] as! String
        let date = commentObj["Date"] as! String
        
        cell.textLabel!.numberOfLines = 0;
        cell.textLabel!.font = myFont
        cell.textLabel?.text = (comment + " - " + creator + " on "  + date)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let commentObject = gameComments[indexPath.row]
        var comment = commentObject["comment"] as! String
        let creator = commentObject["creator"] as! String
        let date = commentObject["Date"] as! String
        comment = comment + " - " + creator + " on "  + date
        let myFont = UIFont(name: "Helvetica", size:17.0)
        return comment.heightWithConstrainedWidth(CGFloat(390), font: myFont!)
    }
    
    
    
    @IBAction func addAComment(sender: AnyObject){
        let alert = UIAlertController(title: "Add a comment", message: "Enter your comment", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Enter your comment"
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            let gameComment = PFObject(className:"gameComments")
            gameComment["comment"] = String(textField.text!)
            gameComment["creator"] = PFUser.currentUser()!.username
            gameComment["gameId"] = self.game!["name"]
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale.currentLocale()
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            let date = NSDate()
            gameComment["Date"] = dateFormatter.stringFromDate(date)
            
            gameComment.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    commentsList.append(gameComment)
                }
                else {}
            }
            self.gameComments.append(gameComment)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

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

extension String{
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat{
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(boundingBox.height + 20)
    }
}
