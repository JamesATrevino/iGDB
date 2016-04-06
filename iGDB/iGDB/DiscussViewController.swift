//
//  DiscussViewController.swift
//  iGDB
//
//  Created by James Trevino on 4/5/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

class DiscussViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var tableView: UITableView!
    var filteredGames = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "discussViewCell")
        //searchController.searchResultsUpdater = self
        //searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        //tableView.tableHeaderView = searchController.searchBar
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("discussViewCell", forIndexPath: indexPath)
        
        let game = gamesList[indexPath.row]
        //if searchController.active && searchController.searchBar.text != "" {
        //    game = filteredGames[indexPath.row]
        //}
        let name = game["name"]
        
        cell.textLabel?.text = (name as! String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("commentsDetailSegue", sender:self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let commentsDetailVC:CommentsDetailViewController = (segue.destinationViewController as? CommentsDetailViewController)!
        //let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
        let indexPath = tableView.indexPathForSelectedRow
        //if searchController.active && searchController.searchBar.text != "" {
        //    gameDetailVC.game = filteredGames[indexPath!.row]
        //}
        //else {
            commentsDetailVC.game = gamesList[(indexPath?.row)!]
        //}
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
