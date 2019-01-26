//
//  MovieDetailViewController.swift
//  MovieTrailers
//
//  Created by Dwayne Lewis on 12/4/18.
//  Copyright © 2018 Dwayne Lewis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import BTYoutubePlayer

class MovieDetailViewController: UIViewController {
    var movie: Movie?
   
    let API_BASE_URL = "https://api.themoviedb.org/3/movie/"
    let API_KEY = "6a544a800d75c7a64e1f8a14b29f208c"
    var videoKey :String  = ""
    let youtubeUrl = "http://youtu.be/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // how to show paragraphs in swift
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode =  .byWordWrapping
        getMoviesviaDetailApi()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var movieImageView: UIImageView! {
        
        didSet {
            
            // Configure the cell
            let imageName =  movie?.backdrop_path ?? ""
            print(imageName)
            let url = URL(string: imageName)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                movieImageView.image = UIImage(data: imageData)
            }
            
            
         
        }
    }
    
    @IBAction func  playTrailer(_ sender: AnyObject)  {
        
        BTYoutubePlayer.loadWith(id: videoKey, target: self)

    }
    
    @IBOutlet var titleLabel: UILabel! {
        
        didSet{
            
            let titleName = movie?.name ?? ""
            
            titleLabel.text = titleName
        }
        
    }
    
    @IBOutlet var descriptionLabel: UILabel! {
        
        
        didSet {
           
            
        let descriptionText = movie?.description ?? ""
            descriptionLabel.text = descriptionText
        }
        
    }
    
    func getMoviesviaDetailApi() {
        
        let params: [String : String] = ["api_key": API_KEY,
                                         "append_to_response":"videos"]
        
        let movieId = movie?.movieId ?? ""
        
        
        Alamofire.request(API_BASE_URL + movieId ,method: .get, parameters: params)
            .responseJSON { response in
                
                
                if response.result.isSuccess {
                    print("Success! Got the Movies data")
                    print(self.API_BASE_URL +  movieId)
                    let movieJSON: JSON = JSON(response.result.value!)
                    print(movieJSON)
                    
                    self.updateMovieVideoData(json:movieJSON)
                    
                }else {
                    print("Error \(String(describing: response.result.error))")
                    
                }
        }
        
    }
    func updateMovieVideoData(json: JSON) {
        
        //let tempResult = json["results"]
        
       
            let tempvideoKey: String = json["videos"]["results"][0]["key"].stringValue
            
            videoKey = tempvideoKey
            

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
