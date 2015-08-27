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
    
  // Mark: Login Button
    @IBAction func loginButton(sender: AnyObject) {
        println("button clicked")
        UdacityLogin.oneSession.loginController(userText.text, passWord: passWordText.text) { (success, errorString) in
            if success {
                println("****" + errorString)
                self.gotoNextScreen()
            } else {
                self.displayError(errorString)
            }
        }
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    testLabel.text = AllMapLocations.oneSession.testPassedInfo
  }
  
  /* Functions */
  
  func gotoNextScreen() {
    println("in gotoNextScreen")
    dispatch_async(dispatch_get_main_queue()) {
      var controller : UITabBarController
      controller = self.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! UITabBarController
      self.presentViewController(controller, animated: true, completion: nil)
//      var controller : UINavigationController
//      controller = self.storyboard?.instantiateViewControllerWithIdentifier("navctrl") as! UINavigationController
//      self.presentViewController(controller, animated: true, completion: nil)
    }
  }
    
    func displayError(errorString: String?) {
        if let errorString = errorString {
            println("it is an error " + errorString)
            dispatch_async(dispatch_get_main_queue()) {
                let alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: .Alert)
                let action = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in println("The Done button was tapped - " + paramAction.title)})
                
                alertController.addAction(action)
                
                self.presentViewController(alertController, animated: true, completion: nil)

            }
        }
    }
    
}

