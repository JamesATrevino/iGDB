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
    var commentsList:[PFObject] = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let name = game!["name"]
        self.headerLabel.text = String(name) + " comments"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "commentCell")
        // Do any additional setup after loading the view.
        let query = PFQuery(className: "gameComments")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects! {
                    if(String(object["gameId"]) == String(self.game!["objectId"]))
                    {
                        self.commentsList.append(object)
                    }

                }
            } else {
                print(error)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//gamesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
        
        
       // cell.textLabel?.text = (name as! String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    @IBAction func addComment(sender: AnyObject) {
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
