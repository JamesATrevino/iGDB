//
//  GameDetailViewController.swift
//  iGDB
//
//  Created by James Trevino on 3/23/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse
class GameDetailViewController: UIViewController {
    
    var game:PFObject?
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var platformsLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    @IBOutlet weak var studioLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var gameReview:[PFObject] = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Do any additional setup after loading the view.
        
        let convertedDate = game!.updatedAt
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        let date2 = dateFormatter.stringFromDate((convertedDate)!)
        
        let name = game!["name"]
        titleLabel.text = name as? String
        //self.title = name as? String
        yearLabel.text = String(game!["year"] as! Int)
        platformsLabel.text = game!["platform"] as? String
        let metaCritic = game!["rating"] as? Double
        metacriticLabel.text = "No metacritic data available"
        self.dateLabel.text = date2
        
        if metaCritic != nil
        {
            metacriticLabel.text = String(metaCritic!)
        }
        
        studioLabel.text = game!["developer"] as? String
        summaryLabel.text = game!["Summary"] as? String
        summaryLabel.editable = false
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "rateGame" {
            let reviewViewVC:ReviewViewController = (segue.destinationViewController as? ReviewViewController)!
            reviewViewVC.game = game
        }
        else if segue.identifier == "allReviews" {
            gameReview.removeAll()
            for gamez in reviewsList {
                if gamez["gamename"] as! String == game!["name"] as! String {
                    self.gameReview.append(gamez)
                }
            }
            let userReviews:ReviewTableViewController = (segue.destinationViewController as? ReviewTableViewController)!
            userReviews.gameReview = self.gameReview
        }
        
        //let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
        /*let indexPath = tableView.indexPathForSelectedRow
        if searchController.active && searchController.searchBar.text != "" {
            gameDetailVC.game = filteredGames[indexPath!.row]
        }
        else {
            gameDetailVC.game = gamesList[(indexPath?.row)!]
        }*/
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
