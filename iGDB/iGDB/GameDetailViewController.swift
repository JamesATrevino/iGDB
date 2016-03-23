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
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = game!["name"]
        self.title = name as? String
        yearLabel.text = String(game!["year"] as! Int)
        platformsLabel.text = game!["platform"] as? String
        metacriticLabel.text = String(game!["rating"] as! Double)
        studioLabel.text = game!["developer"] as? String
        summaryLabel.text = game!["Summary"] as? String
        summaryLabel.editable = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
