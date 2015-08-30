//
//  ViewController.swift
//  PinSample
//
//  Created by Jason on 3/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import MapKit

/**
* This view controller demonstrates the objects involved in displaying pins on a map.
*
* The map is a MKMapView.
* The pins are represented by MKPointAnnotation instances.
*
* The view controller conforms to the MKMapViewDelegate so that it can receive a method
* invocation when a pin annotation is tapped. It accomplishes this using two delegate
* methods: one to put a small "info" button on the right side of each pin, and one to
* respond when the "info" button is tapped.
*/

class MapViewController: UIViewController, MKMapViewDelegate {
  
//  var annotation = MKPointAnnotation()
  var testLit = "From calling program Test"
  var annotations = [MKPointAnnotation]()
  var myLogin = UdacityLogin.oneSession
  var myHelpers = Helpers()
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let firstButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "performRefresh")
    let btnImg = UIImage(named: "pin")
    let secondButton = UIBarButtonItem(image: btnImg, style: .Plain, target: self, action: "performAdd")
    navigationItem.rightBarButtonItems = [firstButton, secondButton]
    navigationItem.title = "On the Map"

    
    
    AllMapLocations.oneSession.loadUpStudentInformationFromDict(AllMapLocations.oneSession.resultMapLocations)
    lloadLocations()
    
//    navigationItem.rightBarButtonItem = UIBarButtonItem(
//      barButtonSystemItem: .Add,
//      target: self,
//      action: "performAdd:")

   
  }
  
  func loadLocations() {
    println("in load locations in viewcontroller")
    // The "locations" array is an array of dictionary objects that are similar to the JSON
    // data that you can download from parse.
    let locations = AllMapLocations.oneSession.resultMapLocations
    
    // We will create an MKPointAnnotation for each dictionary in "locations". The
    // point annotations will be stored in this array, and then provided to the map view.
    
    //var annotations = [MKPointAnnotation]()
    
    // The "locations" array is loaded with the sample data below. We are using the dictionaries
    // to create map annotations. This would be more stylish if the dictionaries were being
    // used to create custom structs. Perhaps StudentLocation structs.
    
    for dictionary in locations {
      
      // Notice that the float values are being used to create CLLocationDegree values.
      // This is a version of the Double type.
      let lat = CLLocationDegrees(dictionary["latitude"] as! Double)
      let long = CLLocationDegrees(dictionary["longitude"] as! Double)
      
      // The lat and long are used to create a CLLocationCoordinates2D instance.
      let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
      
      let first = dictionary["firstName"] as! String
      let last = dictionary["lastName"] as! String
      let mediaURL = dictionary["mediaURL"] as! String
      
      // Here we create the annotation and set its coordiate, title, and subtitle properties
      var annotation = MKPointAnnotation()
      
      annotation.coordinate = coordinate
      annotation.title = "\(first) \(last)"
      annotation.subtitle = mediaURL
      
      // Finally we place the annotation in an array of annotations.
      annotations.append(annotation)
      // println("adding annotations")
    }
    println("about to add annotations the number of annotations is \(self.annotations.count)")
    // When the array is complete, we add the annotations to the map.
    dispatch_async(dispatch_get_main_queue()) {
      self.mapView.addAnnotations(self.annotations)
    }
        println("added map")
  }
  
    
    
    
    func lloadLocations() {
        println("in load locations in viewcontroller")
        // The "locations" array is an array of dictionary objects that are similar to the JSON
        // data that you can download from parse.
        let locations = AllMapLocations.oneSession.studentInformationCollection
        
        // We will create an MKPointAnnotation for each dictionary in "locations". The
        // point annotations will be stored in this array, and then provided to the map view.
        
        //var annotations = [MKPointAnnotation]()
        
        // The "locations" array is loaded with the sample data below. We are using the dictionaries
        // to create map annotations. This would be more stylish if the dictionaries were being
        // used to create custom structs. Perhaps StudentLocation structs.
        
        for dictionary in locations {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(dictionary.latitude as Double)
            let long = CLLocationDegrees(dictionary.longitude as Double)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary.firstName as String
            let last = dictionary.lastName as String
            let mediaURL = dictionary.mediaURL as String
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            var annotation = MKPointAnnotation()
            
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
            // println("adding annotations")
        }
        println("about to add annotations the number of annotations is \(self.annotations.count)")
        // When the array is complete, we add the annotations to the map.
        dispatch_async(dispatch_get_main_queue()) {
            self.mapView.addAnnotations(self.annotations)
        }
        println("added map")
    }
    


    
    // MARK: - * * * *  MKMapViewDelegate
    
    
    // Setup the pins on the map
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .Red
            pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIButton
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    // Responds to taps. It opens the system browser to the URL specified in the annotationViews subtitle property.
    func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            app.openURL(NSURL(string: annotationView.annotation.subtitle!)!)
        }
    }
    
    
    // MARK: - * * * *   Helper Functions
    
    func printTest() {
        println(testLit)
    }
    
    func performAdd(){
        //    dispatch_async(dispatch_get_main_queue()) {
        //      self.mapView.addAnnotations(self.annotations)
        //    }
        //
        //    return
        println("Add new method got called")
        myHelpers.performGo(self.storyboard!, viewController: self)
        
        
        //  var vc: UIViewController = storyboard?.instantiateViewControllerWithIdentifier("doublescreen") as! DoubleScreenViewController
        //  self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func performRefresh(){
        println("Refresh new method got called")

        self.mapView.removeAnnotations(annotations)
        for var i=0; i<10000; i++ {
            var a = "a"
        }
        AllMapLocations.oneSession.getAllMapLocationsNew()  { (success, errorString) in
            if success {
                println("****" + errorString)
                self.loadLocations()
            } else {
                //self.displayError(errorString)
            }
        }

        // AllMapLocations.oneSession.getAllMapLocations(loadLocations)
       // AllMapLocations.oneSession.getAllMapLocations(loadLocations,   myStoryBoard : storyboard!, myViewController: self )
    }
  

}
    //  func hardCodedLocationData() -> [[String : AnyObject]] {
    //    return  [
    //      [
    //        "createdAt" : "2015-02-24T22:27:14.456Z",
    //        "firstName" : "Jessica",
    //        "lastName" : "Uelmen",
    //        "latitude" : 28.1461248,
    //        "longitude" : -82.75676799999999,
    //        "mapString" : "Tarpon Springs, FL",
    //        "mediaURL" : "www.linkedin.com/in/jessicauelmen/en",
    //        "objectId" : "kj18GEaWD8",
    //        "uniqueKey" : 872458750,
    //        "updatedAt" : "2015-03-09T22:07:09.593Z"
    //      ], [
    //        "createdAt" : "2015-02-24T22:35:30.639Z",
    //        "firstName" : "Gabrielle",
    //        "lastName" : "Miller-Messner",
    //        "latitude" : 35.1740471,
    //        "longitude" : -79.3922539,
    //        "mapString" : "Southern Pines, NC",
    //        "mediaURL" : "http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en",
    //        "objectId" : "8ZEuHF5uX8",
    //        "uniqueKey" : 2256298598,
    //        "updatedAt" : "2015-03-11T03:23:49.582Z"
    //      ], [
    //        "createdAt" : "2015-02-24T22:30:54.442Z",
    //        "firstName" : "Jason",
    //        "lastName" : "Schatz",
    //        "latitude" : 37.7617,
    //        "longitude" : -122.4216,
    //        "mapString" : "18th and Valencia, San Francisco, CA",
    //        "mediaURL" : "http://en.wikipedia.org/wiki/Swift_%28programming_language%29",
    //        "objectId" : "hiz0vOTmrL",
    //        "uniqueKey" : 2362758535,
    //        "updatedAt" : "2015-03-10T17:20:31.828Z"
    //      ], [
    //        "createdAt" : "2015-03-11T02:48:18.321Z",
    //        "firstName" : "Jarrod",
    //        "lastName" : "Parkes",
    //        "latitude" : 34.73037,
    //        "longitude" : -86.58611000000001,
    //        "mapString" : "Huntsville, Alabama",
    //        "mediaURL" : "https://linkedin.com/in/jarrodparkes",
    //        "objectId" : "CDHfAy8sdp",
    //        "uniqueKey" : 996618664,
    //        "updatedAt" : "2015-03-13T03:37:58.389Z"
    //      ]
    //    ]
    //  }

