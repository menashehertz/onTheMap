//
//  AllMapLocations.swift
//  PinSample
//
//  Created by Steven Hertz on 7/31/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


class AllMapLocations {

    static let oneSession = AllMapLocations()
    let studentData = UdacityUser.oneSession
    var resultMapLocations = [[String : AnyObject]]()
    var testPassedInfo = "passed info"

    /* Literals needed to get the parse map locations */
    let baseParseURLSecureStringLit = "https://api.parse.com/1/classes/StudentLocation"
 
    /* Literals for thr header field */
    let XParseApplicationIdVal = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    let XParseApplicationIdLit = "X-Parse-Application-Id"
    let XParseRESTAPIKeyVal = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    let XParseRESTAPIKeyLit = "X-Parse-REST-API-Key"
    
    
    /*  Functions to work with parse data  */
    
    // Post an entry into the Parse map locarions database
    func postLocation(cords: CLLocationCoordinate2D, address: String, linkText: String){
        println(" in AllMapLocations.oneSession.postLocation")
//        println("latitude is \(cords.latitude)")
//        println("longitude is \(cords.longitude)")
//        println("address is \(address)")
//        println("link is \(linkText)" )
        
        // prepare the data
        let lat: Double = cords.latitude
        let longi : Double = cords.longitude

        // Prepare the request
        let request = NSMutableURLRequest(URL: NSURL(string: baseParseURLSecureStringLit)!)
        request.addValue(XParseApplicationIdVal, forHTTPHeaderField: XParseApplicationIdLit)
        request.addValue(XParseRESTAPIKeyVal, forHTTPHeaderField: XParseRESTAPIKeyLit)

        // Additional step because it is a post method
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"menashehertz@gmail.com\", \"firstName\": \"\(studentData.firstName)\", \"lastName\": \"\(studentData.lastName)\",\"mapString\": \"\(address)\", \"mediaURL\": \"\(linkText)\" ,\"latitude\": \(cords.latitude as Double), \"longitude\": \(cords.longitude as Double) }".dataUsingEncoding(NSUTF8StringEncoding)
        //request.HTTPBody = "{\"uniqueKey\": \"menashehertz@gmail.com\", \"firstName\": \"Sam\", \"lastName\": \"Ashe2\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": \(lat), \"longitude\": -122.083851}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                println("it was an error")
                return
            }
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        task.resume()
    }
    
    //  Get all map Locations from the Parse database
    func getAllMapLocationsNew(completionHandler: (success: Bool, errorString: String) -> Void)  {
        println("starting func get locations. . .")
        
        // Prepare the request
        let request = NSMutableURLRequest(URL: NSURL(string: baseParseURLSecureStringLit)!)
        request.addValue(XParseApplicationIdVal, forHTTPHeaderField: XParseApplicationIdLit)
        request.addValue(XParseRESTAPIKeyVal, forHTTPHeaderField: XParseRESTAPIKeyLit)
        let session = NSURLSession.sharedSession()
        
        // Do the request
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                println("error")
                completionHandler(success: false, errorString: "Error getting Parse data")
            } else {
                var parsingError: NSError? = nil
                let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
                if parsingError != nil {
                    completionHandler(success: false, errorString: "did not parse the json" )
                } else {
                    // TODO: - The whole dictionary is being saved, should it be split up now? put in error processing with completion handler
                    if let dict = parsedResult["results"] as? [NSDictionary] {
                        self.resultMapLocations = dict as! [[String : AnyObject]]
                        println("number is \(dict.count)")
                        let xx : String
                        for dictEach in dict {
                            if let lastName = dictEach.objectForKey("lastName") as? String {
                            //                println(lastName)
                            //            self.myMapLocation = MapLocation(mapDict: dictEach as! [String : AnyObject])
                            //            println(self.myMapLocation!.mediaURL!)
                            //            self.arrayMapLocations.append(self.myMapLocation!)
                            //            println("append done")
                            }
                        }
                        println("finished for loop")
                        completionHandler(success: true, errorString: "No Error From the Load")
                    }
                }
                //println(NSString(data: data, encoding: NSUTF8StringEncoding))
            }
        }
        task.resume()
    }
    
}

//
//    func getAllMapLocations(loadScreen : () -> Void, myStoryBoard : UIStoryboard, myViewController : UIViewController  ) {
//
//        println("starting func get locations. . .")
//        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
//        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
//        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            if error != nil { // Handle error...
//                println("error")
//                return
//            }
//            var parsingError: NSError? = nil
//            let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
//            if let dict = parsedResult["results"] as? [NSDictionary] {
//                self.resultMapLocations = dict as! [[String : AnyObject]]
//                AllMapLocations.oneSession.resultMapLocations = dict as! [[String : AnyObject]]
//                println("number is \(dict.count)")
//                let xx : String
//                for dictEach in dict {
//                    if let lastName = dictEach.objectForKey("lastName") as? String {
//                        //            println(lastName)
//                        //            self.myMapLocation = MapLocation(mapDict: dictEach as! [String : AnyObject])
//                        //            println(self.myMapLocation!.mediaURL!)
//                        //            self.arrayMapLocations.append(self.myMapLocation!)
//                        //            println("append done")
//                    }
//                }
//                println("finished for loop")
//                //loadScreen()
//
//                if myViewController is UdacityLoginViewController {
//                    println("it is udacity****************************************")
//                    ScreenHelp.gotoMyNextScreen(myStoryBoard, myViewController: myViewController)
//                }
//
//                if myViewController is MapViewController {
//                    println("it is no udacity****************************************")
//                    if let vc = myViewController as? MapViewController {
//                        vc.loadLocations()
//                    }
//                }
//            }
//            //println(NSString(data: data, encoding: NSUTF8StringEncoding))
//        }
//        task.resume()
//    }
//

