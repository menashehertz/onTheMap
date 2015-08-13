//
//  ViewController.swift
//  UdacityLogin
//
//  Created by Steven Hertz on 7/22/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import UIKit
import AVFoundation

class UdacityLoginViewController: UIViewController {
  
  @IBOutlet weak var userText: UITextField!
  
  @IBOutlet weak var passWordText: UITextField!
  
  @IBOutlet weak var testLabel: UILabel!
  
  
  var myMapLocation : MapLocation?
  var arrayMapLocations = [MapLocation]()
  var resultMapLocations = [[String : AnyObject]]()
  

  
  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  let session = NSURLSession.sharedSession()
  
  var loginDicx = [UdacityLogin.oneSession.rootLoginDictLit: [:]] // a dictionary whos first key Udacity contains other dictionaries
  
  var alertController : UIAlertController?
  
  
  func convertToJson(objectToConvert : AnyObject) -> NSString? {
    if NSJSONSerialization.isValidJSONObject(objectToConvert) {
      if let theJSONData = NSJSONSerialization.dataWithJSONObject(objectToConvert, options: NSJSONWritingOptions(0), error: nil) {
        if let theJSONStr = NSString(data: theJSONData, encoding: NSASCIIStringEncoding) {
          return theJSONStr
        }
      }
    }
    return "error"
  }
  
  @IBAction func checkButton() {
    alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
    let action = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in println("The Done button was tapped")})
    
    alertController!.addAction(action)
    
    self.presentViewController(alertController!, animated: true, completion: nil)
  }
  
  @IBAction func loginButton(sender: AnyObject) {
    println("button clicked")
     UdacityLogin.oneSession.loginButton(userText.text, passWord: passWordText.text,  myStoryBoard : storyboard!, myViewController: self)
    return
    
    var subDict : [String : String] = [:]
    // populate the values (login Info) of the sub dictionary
    subDict.updateValue(userText.text, forKey: UdacityLogin.oneSession.userNameLit)
    subDict.updateValue(passWordText.text, forKey: UdacityLogin.oneSession.passwordLit)
    // update the main dictionary with the sub dictionary
    
    loginDicx["udacity"] = subDict
    let theJSONText = convertToJson(loginDicx)
    
    /* 2. Build the URL */
    let urlString = UdacityLogin.oneSession.baseURLSecureStringLit
    let url = NSURL(string: urlString)!
    
    /* 3. Configure the request */
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = "\(theJSONText!)".dataUsingEncoding(NSUTF8StringEncoding)
    
    /* 4. Make the request */
    let task = session.dataTaskWithRequest(request) { data, response, downloadError in
      
      if let error = downloadError {
        println("Could not complete the request \(error)")
      } else {
        
        /* 5. Parse the data */
        let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
        println(NSString(data: newData, encoding: NSUTF8StringEncoding)!)
        var parsingError: NSError? = nil
        let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
        if let dict = parsedResult["account"] as? [String : AnyObject] {
          let registered = dict["registered"] as! Bool
          if registered {
            println("registered")
            AllMapLocations.oneSession.testPassedInfo = "data from login"
            self.getMapLocations()
          } else {
            println("not registed")

          }
        } else {
          println("could not parse the dictionary")
          dispatch_async(dispatch_get_main_queue()) {
            self.checkButton()
          }

        }
      }
    }
    
    /* 7. Start the request */
    task.resume()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    testLabel.text = AllMapLocations.oneSession.testPassedInfo
  }
  
  
  /* Functions */
  
  func gotoNextScreen() {
    dispatch_async(dispatch_get_main_queue()) {
      var controller : UITabBarController
      controller = self.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! UITabBarController
      self.presentViewController(controller, animated: true, completion: nil)
//      var controller : UINavigationController
//      controller = self.storyboard?.instantiateViewControllerWithIdentifier("navctrl") as! UINavigationController
//      self.presentViewController(controller, animated: true, completion: nil)

    }
  }
  
  func getMapLocations() {
    println("starting . . .")
    
    let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { data, response, error in
      if error != nil { // Handle error...
        println("error")
        return
      }
      var parsingError: NSError? = nil
      let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
      if let dict = parsedResult["results"] as? [NSDictionary] {
        self.resultMapLocations = dict as! [[String : AnyObject]]
        AllMapLocations.oneSession.resultMapLocations = dict as! [[String : AnyObject]]
        println("number is \(dict.count)")
        let xx : String
        for dictEach in dict {
          if let lastName = dictEach.objectForKey("lastName") as? String {
            println(lastName)
            self.myMapLocation = MapLocation(mapDict: dictEach as! [String : AnyObject])
            println(self.myMapLocation!.mediaURL!)
            self.arrayMapLocations.append(self.myMapLocation!)
            println("append done")
          }
        }
        println("finished for loop")
        ScreenHelp.gotoMyNextScreen(self.storyboard!, myViewController: self)
        // self.gotoNextScreen()
        
        
      }
      
      //println(NSString(data: data, encoding: NSUTF8StringEncoding))
    }
    task.resume()
  }

}

