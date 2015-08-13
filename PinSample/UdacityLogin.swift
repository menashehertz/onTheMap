//
//  UdacityLogin.swift
//  PinSample
//
//  Created by Steven Hertz on 7/28/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import Foundation



class UdacityLogin {
  static let oneSession = UdacityLogin()
  let baseURLSecureStringLit = "https://www.udacity.com/api/session"
  let rootLoginDictLit = "udacity"
  let userNameLit = "username"
  let passwordLit = "password"
  var counter = 0
  
  func performAdd() {
    println("my login is")
  }
  
  /*
  func presentViewController() {
    var alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
    let action = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in println("The Done button was tapped")})
    
    alertController.addAction(action)
    
    presentViewController(alertController!, animated: true, completion: nil)
  }
  */
  
  
  func stubLoad() {
   // ScreenHelp.gotoMyNextScreen(self.storyboard!, myViewController: self)

    
  }

  
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
  
  
  
  
  func loginButton(userId: String, passWord: String, myStoryBoard : UIStoryboard, myViewController : UIViewController ) {
    println("button clicked from udacity class")
    
    // a dictionary whos first key "udacity" contains other dictionaries
    var loginStringDictionary = [UdacityLogin.oneSession.rootLoginDictLit: [:]]

    // populate the values (login Info) of the sub dictionary
    var subDict : [String : String] = [:]
    subDict.updateValue(userId, forKey: UdacityLogin.oneSession.userNameLit)
    subDict.updateValue(passWord, forKey: UdacityLogin.oneSession.passwordLit)

    // update the main dictionary with the sub dictionary
    loginStringDictionary["udacity"] = subDict
    
    // convert the swift dictionary to Json
    let theJSONText = convertToJson(loginStringDictionary)
    
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
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { data, response, downloadError in
      if let error = downloadError {
        println("Could not complete the request \(error)")
        }
      else {
        /* 5. Parse the data */
        let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
        println(NSString(data: newData, encoding: NSUTF8StringEncoding)!)

        var parsingError: NSError? = nil
        let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
        if let errorParsing = parsingError {
          println("Could not parse the result: \(errorParsing)")
        }
        else {

          if let dict = parsedResult["account"] as? [String : AnyObject] {
            let registered = dict["registered"] as! Bool
            if registered {
              println("registered - succesfully logged into Udacity, next step is to login to parse and get the map locations")
              AllMapLocations.oneSession.getAllMapLocations(self.stubLoad, myStoryBoard: myStoryBoard, myViewController: myViewController)
              }
            else {
              println("didn't have the key registerd in the dictionary - Not valid credentials")
              }
            }
          else {
            println("didn't have the KEY account in the dictionary" )
            dispatch_async(dispatch_get_main_queue()) {
//            self.checkButton()
              }
            }

        } // end of the succesful completion of the parsing
      } // end of the succesful completion of dataTask
    } // end of closure
    
    /* 7. Start the request */
    task.resume()
  }

  
  
  
}

