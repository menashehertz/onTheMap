//
//  UdacityUser.swift
//  PinSample
//
//  Created by Steven Hertz on 8/25/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import Foundation

struct Account {
    let registered: Bool
    let key: String
}

struct Session {
    let id: String
    let expiration: String
}

class UdacityUser {
    var account: Account
    var session: Session
    
    init(dict :[String:[String:AnyObject]] ) {
        self.account = Account(registered: dict["account"]!["registered"] as! Bool, key: dict["account"]!["key"] as! String)
        self.session = Session(id: dict["session"]!["id"] as! String, expiration: dict["session"]!["expiration"]  as! String)
    }
    //    init(registered: Bool, key: String, id: String, expiration: String ) {
    //        self.account = Account(registered: registered, key: key)
    //        self.session = Session(id: id, expiration: expiration)
    //    }
}
