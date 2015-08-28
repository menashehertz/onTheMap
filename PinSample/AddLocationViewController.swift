//
//  DoubleScreenViewController.swift
//  LearnMap
//
//  Created by Steven Hertz on 8/7/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import UIKit


import MapKit

class AddLocationViewController: UIViewController {
  
  var coords: CLLocationCoordinate2D!
    let studentData = UdacityUser.oneSession
  
  @IBOutlet weak var map: MKMapView!
  @IBOutlet weak var address: UITextField!
  @IBOutlet weak var screenView1: UIView!
  @IBOutlet weak var screenView2: UIView!
  @IBOutlet weak var linkText: UITextField!
  @IBOutlet weak var activityInd: UIActivityIndicatorView!
  
  @IBAction func findLocation(sender: AnyObject) {
    println("findLocation button was pressed")
    convertAddressToMapLocation()
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
  
  //
  func populateMapWithLocation(coords: CLLocationCoordinate2D) {
    println("in build map")
    
    // Make the span of the map, use a higher number to cover more area
    var span = MKCoordinateSpanMake(0.0002, 0.0002)
    // region to show on the map
    var region = MKCoordinateRegionMake(coords, span)
    
    map.setRegion(region, animated: true)
        
    // Setup the annotation with location and the title and other info
    var annotation = MKPointAnnotation()
    annotation.coordinate = coords
    annotation.title = studentData.firstName + " " + studentData.lastName
    //annotation.subtitle = "xxx"
    
    // Add it to the map
    map.addAnnotation(annotation)
    activityInd.stopAnimating()
  }
    
  // takes a text location and converts it to a geoLocation
  func convertAddressToMapLocation() {
    println("in build location")
    activityInd.startAnimating()
    let destination = address.text
    //    let destination = "350 5th Avenue New York, NY"
    CLGeocoder().geocodeAddressString(destination, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) in
      if error != nil{
        println("error")
        /* Handle the error here perhaps by displaying an alert */
      } else {
        /* Convert the CoreLocation destination placemark to a MapKit placemark */
        
        let placemark = placemarks[0] as! CLPlacemark
//        let destinationCoordinates = placemark.location.coordinate
//        let coords = placemark.location.coordinate
        self.coords = placemark.location.coordinate
        println(" latitude \(self.coords.latitude) and longitude is \(self.coords.longitude)" )
        self.populateMapWithLocation(placemark.location.coordinate)
      }
    })
  }
  
  func postLocation(){
    // Put map location into the parse database
    AllMapLocations.oneSession.postLocation(coords, address: address.text, linkText: linkText.text)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityInd.hidesWhenStopped = true
    
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
