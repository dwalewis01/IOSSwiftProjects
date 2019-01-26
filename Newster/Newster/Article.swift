//
//  Article.swift
//  Newster
//
//  Created by Dwayne Lewis on 12/22/18.
//  Copyright © 2018 Dwayne Lewis. All rights reserved.
//

import Foundation

class Article {
    
    var title = ""
    var url = ""
    var description = ""
    var urlToImage = ""
    
    
    init(title : String, url : String, description : String, urlToImage : String) {
        
        self.title = title
        self.url = url
        self.description = description
        self.urlToImage = urlToImage
        
    }
    
    
    
}
