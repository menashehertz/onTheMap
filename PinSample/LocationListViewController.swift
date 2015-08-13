//
//  LocationListViewController.swift
//  PinSample
//
//  Created by Steven Hertz on 8/2/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit

class LocationListViewController: UITableViewController {
  
    let locations = AllMapLocations.oneSession.resultMapLocations

  
  func performAdd(sender: UIBarButtonItem){
    println("Add method got called")
    
// MARK: manually using the navigation controller not working
    
//    
//    // Instantiate the ViewController Screen Using Storyboard ID
//    let nextScreenViewController = storyboard!.instantiateViewControllerWithIdentifier("addlocation") as! UIViewController
//    
//    // Create a UINavigationController object and push the "nextScreenViewController"
////    self.navigationController?.presentViewController(<#viewControllerToPresent: UIViewController#>, animated: <#Bool#>, completion: <#(() -> Void)?##() -> Void#>)
//    let nextScreenNavigationController = self.navigationController
////    nextScreenNavigationController!.pushViewController(nextScreenViewController, animated: false)
//    
//    // present the navigation View Controller
//    nextScreenNavigationController?.pushViewController(nextScreenViewController, animated: false)
//    presentViewController(nextScreenNavigationController!, animated: true, completion: nil)
//    

    
    
//    let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
//    request.HTTPMethod = "POST"
//    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
//    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.HTTPBody = "{\"uniqueKey\": \"menashehertz@gmail.com\", \"firstName\": \"Sam\", \"lastName\": \"Ashe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".dataUsingEncoding(NSUTF8StringEncoding)
//    let session = NSURLSession.sharedSession()
//    let task = session.dataTaskWithRequest(request) { data, response, error in
//      if error != nil { // Handle error…
//        println("it was an error")
//        return
//      }
//      println(NSString(data: data, encoding: NSUTF8StringEncoding))
//    }
//    task.resume()

  }
  

  
    override func viewDidLoad() {
        super.viewDidLoad()
// MARK: manually adding the button not working
      
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//          barButtonSystemItem: .Add,
//          target: self,
//          action: "performAdd:")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      println("in table section")
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("in table count")
        return AllMapLocations.oneSession.resultMapLocations.count
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section \(section)"
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        let dictRow = AllMapLocations.oneSession.resultMapLocations[indexPath.row]
        let myMapLocation = MapLocation(mapDict: dictRow as [String : AnyObject])
//        cell.textLabel?.text = (dictRow["lastName"] as! String)
        cell.textLabel?.text = "\(myMapLocation.firstName!) \(myMapLocation.lastName!)"
        return cell
    }
  
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      let dictRow = AllMapLocations.oneSession.resultMapLocations[indexPath.row]
      let myMapLocation = MapLocation(mapDict: dictRow as [String : AnyObject])
      UIApplication.sharedApplication().openURL(NSURL(string: myMapLocation.mediaURL!)!)
      println("you selected row \(indexPath.row) ")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
