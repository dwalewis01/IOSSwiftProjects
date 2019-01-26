//
//  NewsTableViewController.swift
//  Newster
//
//  Created by Dwayne Lewis on 12/22/18.
//  Copyright © 2018 Dwayne Lewis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsTableViewController: UITableViewController {
    
    var newsArticles : [Article] = []
   
    var api_base_url : String = "https://newsapi.org/v2/top-headlines?" + "country=us&" + "apiKey=485f3536a44a4a7fafa56f290b56cd87"
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.getNewsviaApi()
        self.tableView.contentInset.bottom = -40
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
        return newsArticles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath) as! NewsTableViewCell

        // Configure the cell...
        
        
        let news = newsArticles[indexPath.row]
        let imageName =  news.urlToImage
        let url = URL(string: imageName)
        let placeholder = URL(string:"https://via.placeholder.com/375x160?text=Image+Not+Available")
        let data = try? Data(contentsOf: url ?? placeholder! )
        
        

        if let imageData = data {
            cell.newImage?.image = UIImage(data: imageData)
        }
        
        cell.title?.text = news.title
   
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        cell.alpha = 0
        
        
        UIView.animate(withDuration:1.0, animations: { cell.alpha = 1 })
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
    
    func getNewsviaApi() {
        
        
        
        Alamofire.request(api_base_url ,method: .get)
            .responseJSON { response in
                
                
                if response.result.isSuccess {
                    print("Success! Got the News data")
                    
                    let newsJSON: JSON = JSON(response.result.value!)
                     print(newsJSON)
                    self.updateNewsData(json: newsJSON)
                    self.tableView.reloadData()
                    
                }else {
                    print("Error \(String(describing: response.result.error))")
                    
                }
        }
        
    }
    
    // JSON Parsing
    /**************************/
    
    func updateNewsData(json: JSON) {
        
      let totalResult = Int(json["articles"].count) - 1
        
        for i in 0...totalResult{
            
            
            let tempNewsTitle : String =  json["articles"][i]["title"].stringValue
            
            let tempNewsDesc :String = json["articles"][i]["content"].stringValue
            
            let tempImageName :String = json["articles"][i]["urlToImage"].stringValue
            
            let tempUrl : String = json["articles"][i]["url"].stringValue
            // print(tempNewsTitle)
            newsArticles.append(Article(title: tempNewsTitle, url: tempUrl, description: tempNewsDesc , urlToImage: tempImageName))
            
            
            
        }
        
       // print(newArticles[0].title)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            performSegue(withIdentifier: "showWebView", sender: self)
   
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showWebView" {
            
            if let destinationController = segue.destination as? WebViewController,
            
                let indexPath = tableView.indexPathForSelectedRow {
                
                destinationController.targetURL = newsArticles[indexPath.row].url
            }
        }
        
    }

}
//extension UIImageView {
//    public func imageFromServerURL(urlString: String) {
//        self.image = nil
//        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
//            
//            if error != nil {
//                print(error)
//                return
//            }
//            DispatchQueue.main.async(execute: { () -> Void in
//                let image = UIImage(data: data!)
//                self.image = image
//            })
//            
//        }).resume()
//    }}
