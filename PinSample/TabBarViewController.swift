//
//  TabBarViewController.swift
//  PinSample
//
//  Created by Steven Hertz on 8/4/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "performX:")
        let secondButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "performY:")
        //self.navigationController?.navigationItem.rightBarButtonItems = [firstButton, secondButton]
        navigationItem.rightBarButtonItems = [firstButton, secondButton]
 

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
