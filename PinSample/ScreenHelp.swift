//
//  ScreenHelp.swift
//  PinSample
//
//  Created by Steven Hertz on 8/12/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

class ScreenHelp {
  class func gotoMyNextScreen(myStoryBoard : UIStoryboard, myViewController : UIViewController) {
    dispatch_async(dispatch_get_main_queue()) {
      println("in gotonext screen function")
      var controller : UITabBarController
      controller = myStoryBoard.instantiateViewControllerWithIdentifier("tabbar") as! UITabBarController
      myViewController.presentViewController(controller, animated: true, completion: nil)
      //      var controller : UINavigationController
      //      controller = self.storyboard?.instantiateViewControllerWithIdentifier("navctrl") as! UINavigationController
      //      self.presentViewController(controller, animated: true, completion: nil)
    }
  }
  
}
