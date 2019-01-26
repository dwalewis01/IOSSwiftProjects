//
//  TheaterViewController.swift
//  MovieTrailers
//
//  Created by Dwayne Lewis on 1/7/19.
//  Copyright © 2019 Dwayne Lewis. All rights reserved.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var Theaters : [Theater]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
           showNearby()
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
    
    
    


    func showNearby() {
        
        
        let searchRequest = MKLocalSearch.Request()
        
        searchRequest.naturalLanguageQuery = "Movie Theaters"
       // searchRequest.region = mapView.region
        
        
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { (response, error ) -> Void in
            guard let response = response
                
                else {
                    
                    if let error = error {
                        
                        print(error)
                        
                    }
                    return
            }
//            //  print(response)
           let mapItems = response.mapItems
           // var nearbyAnnotation: [MKAnnotation] = []

           if mapItems.count > 0 {

                for item in mapItems {

                    // Add annotation
                    self.split(item: item.placemark.description)

                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber


//                    if let location = item.placemark.location {
//                        annotation.coordinate = location.coordinate
//                        nearbyAnnotation.append(annotation)
//
//                        self.mapView.showAnnotations(nearbyAnnotation, animated:true )
//                        self.mapView.selectAnnotation(annotation, animated: true)
//                    }

                }
            }
            
            
            
        }
        
        
        
    }
    
    
    func split(item: String) {
        
        let fullArr = item.components(separatedBy: ",")
        let tempname =  fullArr[0]
        let tempLocation = fullArr[1] + fullArr[2] + fullArr[3]
        
        Theaters.append(Theater(name: tempname, location: tempLocation))
        
        print(Theaters)
    }

}
