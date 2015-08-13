//
//  DoubleScreenViewController.swift
//  LearnMap
//
//  Created by Steven Hertz on 8/7/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DoubleScreenViewController: UIViewController {
  
  var cords: CLLocationCoordinate2D!
  
  @IBOutlet weak var map: MKMapView!
  @IBOutlet weak var address: UITextField!
  @IBOutlet weak var screenView1: UIView!
  @IBOutlet weak var screenView2: UIView!
  @IBOutlet weak var linkText: UITextField!
  
  @IBAction func findLocation(sender: AnyObject) {
    println("findLocation button was pressed")
    getLocation()
    screenView1.hidden = true
    screenView2.hidden = false
  }
  @IBAction func submit(sender: AnyObject) {
    println("submit button was pressed")
    postLocation()
    screenView2.hidden = true
    screenView1.hidden = false
  }
  
  @IBAction func goBack(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  func buildMap(coords: CLLocationCoordinate2D) {
    println("in build map")
    
    // Make the coordinates where the pin will be put
    //let coords = CLLocationCoordinate2DMake(40.7483, -73.984911)
    
    // Make the span of the map, use a higher number to cover more area
    var span = MKCoordinateSpanMake(0.0002, 0.0002)
    // region to show on the map
    var region = MKCoordinateRegionMake(coords, span)
    
    map.setRegion(region, animated: true)
    
    
    // Setup the annotation with location and the title and other info
    var annotation = MKPointAnnotation()
    annotation.coordinate = coords
    annotation.title = "Empire state building"
    annotation.subtitle = "Tallest Building"
    
    // Add it to the map
    map.addAnnotation(annotation)
    
  }
  
  func getLocation() {
    println("in build location")
    let destination = address.text
    //    let destination = "350 5th Avenue New York, NY"
    CLGeocoder().geocodeAddressString(destination, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) in
      if error != nil{
        println("error")
        /* Handle the error here perhaps by displaying an alert */
      } else {
        /* Convert the CoreLocation destination placemark to a MapKit placemark */
        
        let placemark = placemarks[0] as! CLPlacemark
        let destinationCoordinates = placemark.location.coordinate
        let coords = placemark.location.coordinate
        self.cords = placemark.location.coordinate
        println(" latitude \(coords.latitude) and longitude is \(coords.longitude)" )
        self.buildMap(placemark.location.coordinate)
      }
    })
  }
  
  func postLocation(){
    println("latitude is \(cords.latitude)")
    println("longitude is \(cords.longitude)")
    println("address is \(address.text)")
    println("link is \(linkText.text)" )
    
    let lat: Double = cords.latitude
    let longi : Double = cords.longitude
    let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
    request.HTTPMethod = "POST"
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = "{\"uniqueKey\": \"menashehertz@gmail.com\", \"firstName\": \"Sam\", \"lastName\": \"Aabb\",\"mapString\": \"\(address.text)\", \"mediaURL\": \"\(linkText.text)\" ,\"latitude\": \(cords.latitude as Double), \"longitude\": \(cords.longitude as Double) }".dataUsingEncoding(NSUTF8StringEncoding)
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
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
