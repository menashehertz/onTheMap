//
//  Helpers.swift
//  PinSample
//
//  Created by Steven Hertz on 8/6/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit
class Helpers: NSObject {
  func performGo(storyBoard: UIStoryboard, viewController: UIViewController){
    println("from helper")
    var vc: DoubleScreenViewController = storyBoard.instantiateViewControllerWithIdentifier("doublescreen") as! DoubleScreenViewController
    viewController.presentViewController(vc, animated: true, completion: nil)
  }
  func addButtons(storyBoard: UIStoryboard, viewController: UIViewController){
    println("from helper")
    var vc: DoubleScreenViewController = storyBoard.instantiateViewControllerWithIdentifier("doublescreen") as! DoubleScreenViewController
    viewController.presentViewController(vc, animated: true, completion: nil)
  }

}

