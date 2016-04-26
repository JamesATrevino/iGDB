//
//  DatabaseTableViewController.swift
//  iGDB
//
//  Created by Marcus Cruz on 3/22/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import Parse
import UIKit

extension DatabaseTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class DatabaseTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)
    var filteredGames = [PFObject]()
    //let barStyle: UIBarStyle = 2;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.translucent = false
        //searchController.searchBar.barStyle
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredGames = gamesList.filter { game in
            return game["name"].lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    //func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    //    self.searchController.active = false
    //}
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.active && searchController.searchBar.text != "" {
            return filteredGames.count
        }
        return gamesList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dbID", forIndexPath: indexPath)

        var game = gamesList[indexPath.row]
        if searchController.active && searchController.searchBar.text != "" {
            game = filteredGames[indexPath.row]
        }
        let name = game["name"]

        cell.textLabel?.text = (name as! String)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("details", sender: self)
        self.searchController.active = false
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let gameDetailVC:GameDetailViewController = (segue.destinationViewController as? GameDetailViewController)!
        //let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
        let indexPath = tableView.indexPathForSelectedRow
        if searchController.active && searchController.searchBar.text != "" {
            gameDetailVC.game = filteredGames[indexPath!.row]
        }
        else {
            gameDetailVC.game = gamesList[(indexPath?.row)!]
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
