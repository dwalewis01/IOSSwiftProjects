//
//  MapViewController.swift
//  MovieTrailers
//
//  Created by Dwayne Lewis on 1/1/19.
//  Copyright © 2019 Dwayne Lewis. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    var theater = Theater()
    
    let locationManager = CLLocationManager()
    var currentPlacemark: CLPlacemark?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.showsUserLocation = true
        
        //Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(theater.location, completionHandler: {placemarks, error in
            
            if let error = error {
                
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                
                // Get the first placemark
                let placemark = placemarks[0]
                
                
                //add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.theater.name
                
                if let location = placemark.location {
                    
                    annotation.coordinate = location.coordinate
                    
                   self.mapView.showAnnotations([annotation], animated: true )
                   self.mapView.selectAnnotation(annotation, animated: true )
                    
                }
                
            }
            
        })
        
        
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            
            mapView.showsUserLocation = true
        }
        
    
    // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"

        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        // Reuse the annotation if possible
        var annotationView: MKAnnotationView?

        if #available(iOS 11.0, *) {
            var markerAnnotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

            if markerAnnotationView == nil {
                markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                markerAnnotationView?.canShowCallout = true
            }

            markerAnnotationView?.glyphText = " "
            markerAnnotationView?.markerTintColor = UIColor.orange

            annotationView = markerAnnotationView

        } else {

            var pinAnnotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

            if pinAnnotationView == nil {
                pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                pinAnnotationView?.canShowCallout = true
                pinAnnotationView?.pinTintColor = UIColor.orange
            }

            annotationView = pinAnnotationView
        }

        return annotationView
    }
    
  
}
