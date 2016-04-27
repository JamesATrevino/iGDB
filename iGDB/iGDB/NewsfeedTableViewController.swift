//
//  NewsfeedTableViewController.swift
//  iGDB
//
//  Created by Marcus Cruz on 4/25/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit

class NewsfeedTableViewController: UITableViewController, NSXMLParserDelegate {
    
    
    @IBOutlet var newsfeed: UITableView!
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var link = NSMutableString()
    var newsImage = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsfeed.separatorColor = UIColor.clearColor();
        beginParsing()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func beginParsing() {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://www.polygon.com/rss/group/news/index.xml"))!)!
        parser.delegate = self
        parser.parse()
        //self.tableView.reloadData()
        print("number of posts: \(posts.count)")
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        //print(element)
        if (elementName as NSString).isEqualToString("entry")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            link = NSMutableString()
            link = ""
            newsImage = NSMutableString()
            newsImage = ""
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if element.isEqualToString("title") {
            //print(element)
            title1.appendString(string)
        }
        else if element.isEqualToString("id") {
            link.appendString(string)
        }
        else if element.isEqualToString("content") {
            //print(string)
            var parsedString = []
            var string1 = ""
            if string.containsString("src=") {
                parsedString = string.componentsSeparatedByString("src=")
            }
            if parsedString.count > 1 {
                string1 = parsedString[1] as! String
                parsedString = string1.componentsSeparatedByString("\"")
                string1 = parsedString[1] as! String
                //print(string1)
                //print(parsedString)
            }
            //print("new content: \(parsedString)")
            newsImage.appendString(string1)
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqualToString("entry") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
            }
            if !link.isEqual(nil) {
                elements.setObject(link, forKey: "link")
            }
            if !newsImage.isEqual(nil) {
                elements.setObject(newsImage, forKey: "image")
                
            }
            posts.addObject(elements)
        }
        //print(posts.count)
    }
    
    func parserDidEndDocument(parser: NSXMLParser){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }

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
        return self.posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //print("before getting cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("news", forIndexPath: indexPath)
        //print("creating cells")
        // Configure the cell...
        (cell as! CardCell).newsTitle.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as? String
        (cell as! CardCell).newsText.text = posts.objectAtIndex(indexPath.row).valueForKey("link") as? String
        
        let url = posts.objectAtIndex(indexPath.row).valueForKey("image") as! String
        //print(url)
        if url != "" {
            let checkedUrl = NSURL(string: url)
            (cell as! CardCell).newsImage.contentMode = .ScaleAspectFit
            downloadImage(checkedUrl!, cell: (cell as! CardCell))
        }
        
        return cell
    }

    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL, cell: CardCell){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                cell.newsImage.image = UIImage(data: data)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedItem = posts.objectAtIndex(indexPath.row)
        let url = selectedItem.valueForKey("link") as! String
        if url != "" {
            let parseURL = url.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            let checkedURL = NSURL(string: parseURL)
            print("opening URL \(parseURL)")
            UIApplication.sharedApplication().openURL(checkedURL!)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
