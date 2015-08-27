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
    
    /* Literals needed to login*/
    let baseURLSecureStringLit = "https://www.udacity.com/api/session"
    let rootLoginDictLit = "udacity"
    let userNameLit = "username"
    let passwordLit = "password"

    var counter = 0

    /* Main Process Functions */
    
    /*
    Drives the process and does 2 things
    - logs in to Udacity
    - and if succesful gets the location data from Parse
    */
    func loginController(userId: String, passWord: String, completionHandler: (success: Bool, errorString: String) -> Void) {
        self.loginToUdacity(userId, passWord: passWord)  { (success, errorString) in
            if success {
                // completionHandler(success: true, errorString: "No error")
                   AllMapLocations.oneSession.getAllMapLocationsNew()  { (success, errorString) in
                    if success {
                        completionHandler(success: true, errorString: "From loginController  " + errorString)
                    } else {
                        completionHandler(success: false, errorString: errorString)
                    }
                 }
            } else {
                completionHandler(success: false, errorString: errorString)
            }
        }
    }

    /*
    Logs in to Udacity
    Takes a closure to will do another step if the login is complete
    */
    func loginToUdacity(userId: String, passWord: String, completionHandler: (success: Bool, errorString: String) -> Void) {
        println("button clicked from udacity class")
        
        // a dictionary whos first key "udacity" contains other dictionaries
        var loginStringDictionary = [rootLoginDictLit: [:]]
        
        // populate the values (login Info) of the sub dictionary
        var subDict : [String : String] = [:]
        subDict.updateValue(userId, forKey: userNameLit)
        subDict.updateValue(passWord, forKey: passwordLit)
        
        // update the main dictionary with the sub dictionary
        loginStringDictionary[rootLoginDictLit] = subDict
        
        // convert the swift dictionary to Json
        let theJSONText = convertToJson(loginStringDictionary)!
        
        /* 2. Build the URL */
        let urlString = UdacityLogin.oneSession.baseURLSecureStringLit
        let url = NSURL(string: urlString)!
        
        /* 3. Configure the request */
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "\(theJSONText)".dataUsingEncoding(NSUTF8StringEncoding)
        
        /* 4. Make the request */
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, downloadError in
            if let error = downloadError {
                println("Could not complete the request \(error)")
            }
            else {
                /* 5. Parse the data */
                let downloadedDataCleaned = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                println(NSString(data: downloadedDataCleaned, encoding: NSUTF8StringEncoding)!)
                
                var parsingError: NSError? = nil
                let parsedResult = NSJSONSerialization.JSONObjectWithData(downloadedDataCleaned, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
                if let errorParsing = parsingError {
                    println("Could not parse the result: \(errorParsing)")
                }
                else {
                    if let dict = parsedResult["account"] as? [String : AnyObject] {
                        let registered = dict["registered"] as! Bool
                        if registered {
                            println("registered - succesfully logged into Udacity, next step is to login to parse and get the map locations")
                            var myUlogin = UdacityUser(dict: parsedResult as! [String:[String:AnyObject]])
                            println("registered \(myUlogin.account.key)")
                            completionHandler(success: true, errorString: "No error")
                        }
                        else {
                            println("didn't have the key registerd in the dictionary - Not valid credentials")
                            completionHandler(success: false, errorString: "didn't have the key registerd in the dictionary - Not valid credentials")
                        }
                    }
                    else {
                        if let errorDict = parsedResult as? [String : AnyObject] {
                            let errorText: AnyObject? = errorDict["error"]
                            println("in dict didn't have the KEY account in the dictionary" )
                            completionHandler(success: false, errorString: errorText! as! String)
                        } else {
                            println("not in dict didn't have the KEY account in the dictionary" )
                            completionHandler(success: false, errorString: "didn't have the KEY account in the dictionary")
                        }
                        //dispatch_async(dispatch_get_main_queue()) {
                            //            self.checkButton()
                        //}
                    }
                } // end of the succesful completion of the parsing
            } // end of the succesful completion of dataTask
        } // end of closure
        
        /* 7. Start the request */
        task.resume()
    }
    

    /* Helper Functions */

    /**
    Converts a dictionary to a Json string
    
    :param: objectToConvert is a swift dictionary
    :returns: Json string
    */
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
    
//    func performAdd() {
//        println("my login is")
//    }
//    
//    func stubLoad() {
//        // ScreenHelp.gotoMyNextScreen(self.storyboard!, myViewController: self)
//    }
//    
    
    
    /*
    func presentViewController() {
    var alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
    let action = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in println("The Done button was tapped")})
    
    alertController.addAction(action)
    
    presentViewController(alertController!, animated: true, completion: nil)
    }
    */
  
  
}

