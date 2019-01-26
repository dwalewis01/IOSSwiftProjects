//
//  MovieCollectionViewController.swift
//  MovieTrailers
//
//  Created by Dwayne Lewis on 11/13/18.
//  Copyright © 2018 Dwayne Lewis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController {
    
    @IBOutlet private weak var collection: UICollectionView!
    //let defaults = UserDefaults.standard

    let API_BASE_URL = "https://api.themoviedb.org/3/discover/movie"
    let API_KEY = "6a544a800d75c7a64e1f8a14b29f208c"
    

    
    let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500"

    var movieSet = [Movie]()

    
    var dateNow = ""
    var dateNextMonth = ""
    var dateComponent = DateComponents()
    let monthsToAdd = -8
   
    
 
   
    
    //var movieDataModel = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
            let width = (view.frame.size.width - 20) / 3
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 201)
        // Register cell classes
         self.getMoviesviaApi()
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailSegue" {
            
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                
                let destinationController = segue.destination as! MovieDetailViewController
                
                destinationController.movie = movieSet[indexPaths[0].row]
                collectionView?.deselectItem(at: indexPaths[0], animated:false )
                
               // print(destinationController.movie!)
            }
        }
    }


    @IBAction func unwindToHome(segue: UIStoryboardSegue){
        
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(movieSet.count)
        return movieSet.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
    
        // Configure the cell
        let movie = movieSet[indexPath.row]
        let imageName =  movie.imageName
        let url = URL(string: imageName)
        
        do {
        let data = try Data(contentsOf: url!)
        
        let imageData = data
        
        cell.movieImageView.image = UIImage(data: imageData)
            
        } catch {
            
            print("Error \(error)")
        }

       

        
        return cell
    }
    
    
    //***********************Networking ************************
    
    func getMoviesviaApi() {
        
        let currentDate = getCurrentDate()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateNow = dateFormatter.string(from: currentDate)
        print("date now " + dateNow)
        
        
        
        dateComponent.month = monthsToAdd
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        dateNextMonth = dateFormatter.string(from: futureDate!)
        print("date next" + dateNextMonth)
        
        let params: [String : String] = ["api_key": API_KEY,
                                  "primary_release_date.gte" : dateNextMonth ,
                                  "primary_release_date.lte" : dateNow ,
                                  "page": "10",
                                  "append_to_response":"videos"]
      
        
        
        Alamofire.request(API_BASE_URL,method: .get, parameters: params)
            .responseJSON { response in
                
                
                if response.result.isSuccess {
                    print("Success! Got the Movies data")
                    
                    let movieJSON: JSON = JSON(response.result.value!)
                   // print(movieJSON)
                   self.updateMovieData(json: movieJSON)
                   self.collectionView.reloadData()
                    
                    
                }else {
                    print("Error \(String(describing: response.result.error))")
                    
                }
       }
        
    }
    
    // JSON Parsing
    /**************************/
    
    func updateMovieData(json: JSON) {
        
        //let tempResult = json["results"]
        
        for i in 0...16{ // or [[String:AnyObject]]
            
            let tempMovieId : String = json["results"][i]["id"].stringValue
            let tempMovieTitle : String =  json["results"][i]["title"].stringValue
           
            let tempMovieDesc :String = json["results"][i]["overview"].stringValue
            
            let tempImageName :String = IMAGE_BASE_URL  + json["results"][i]["poster_path"].stringValue
            let tempBackDrop:String = IMAGE_BASE_URL + json["results"][i]["backdrop_path"].stringValue
             //print(tempImageName)
            movieSet.append(Movie(movieId: tempMovieId, name: tempMovieTitle, imageName: tempImageName, description: tempMovieDesc, backdrop_path:tempBackDrop))
            
          
           
        }
        
        //print(movieSet)
    }
 
    



    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    func getCurrentDate()-> Date {
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.hour = Calendar.current.component(.hour, from: now)
        nowComponents.minute = Calendar.current.component(.minute, from: now)
        nowComponents.second = Calendar.current.component(.second, from: now)
        nowComponents.timeZone = NSTimeZone.local
        now = calendar.date(from: nowComponents)!
        return now as Date
    }

}
