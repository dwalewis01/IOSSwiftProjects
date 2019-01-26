//
//  TheaterTableViewController.swift
//  MovieTrailers
//
//  Created by Dwayne Lewis on 1/7/19.
//  Copyright © 2019 Dwayne Lewis. All rights reserved.
//

import UIKit
import MapKit

class TheaterTableViewController: UITableViewController {
    
    var theaters : [Theater]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNearby()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return theaters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TheaterTableViewCell
        
        
        
        cell.name.text = theaters[indexPath.row].name
        cell.location.text = theaters[indexPath.row].location
        
       // cell.location!.text = Theaters[indexPath.row].location

        // Configure the cell...
        
    

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
            
            self.tableView.reloadData()
            
        }
        
        
        
    }

      override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
            
            if segue.identifier == "showMap" {
                 let destinationController = segue.destination as! MapViewController
                
                    if let indexPath = tableView.indexPathForSelectedRow {
                
               
                destinationController.theater = theaters[indexPath.row]
                
                }
            }
        }
 
    
    
    func split(item: String) {
        
        let fullArr = item.components(separatedBy: ",")
        let tempname =  fullArr[0].trimmingCharacters(in: .whitespaces)
        let tempLocation = fullArr[1].trimmingCharacters(in: .whitespaces) + fullArr[2] + fullArr[3]
        
        theaters.append(Theater(name: tempname, location: tempLocation))
        
        print(theaters)
    }

}
