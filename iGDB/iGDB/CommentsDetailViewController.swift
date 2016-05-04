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
        let comment = gameComments[indexPath.row]
        cell.textLabel!.numberOfLines = 0;
        cell.textLabel!.font = myFont
        cell.textLabel?.text = (comment["comment"] as! String)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let commentObject = commentsList[indexPath.row]
        let comment = commentObject["comment"] as! String
        let myFont = UIFont(name: "Helvetica", size:17.0)
        return comment.heightWithConstrainedWidth(CGFloat(300), font: myFont!)
    }
    
    
    
    @IBAction func addAComment(sender: AnyObject) {
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
        return ceil(boundingBox.height)
    }
}
