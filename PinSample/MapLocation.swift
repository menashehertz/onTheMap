//
//  MapLocation.swift
//  PinSample
//
//  Created by Steven Hertz on 7/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

class MapLocation {
  var firstName : String?
  var lastName : String?
  var latitude : Float?
  var longitude : Float?
  var mediaURL : String?
  var mapString : String?
  var objectId : String?
  var uniqueKey : String?
  
  
  
  init(mapDict: [String : AnyObject]) {
    if let tempfirstName = mapDict["firstName"] as? String {
      self.firstName = tempfirstName
    }
    if let templastName = mapDict["lastName"] as? String {
      self.lastName = templastName
    }
    if let templatitude = mapDict["latitude"] as? Float? {
      self.latitude = templatitude
    }
    if let templongitude = mapDict["longitude"] as? Float? {
      self.longitude = templongitude
    }
    if let tempmediaURL = mapDict["mediaURL"] as? String {
      self.mediaURL = tempmediaURL
    }
    if let tempmapString = mapDict["mapString"] as? String {
      self.mapString = tempmapString
    }
    if let tempobjectId = mapDict["objectId"] as? String {
      self.objectId = tempobjectId
    }
    if let tempuniqueKey = mapDict["uniqueKey"] as? String {
      self.uniqueKey = tempuniqueKey
    }
  }
}

