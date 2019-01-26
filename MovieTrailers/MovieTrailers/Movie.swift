//
//  Movie.swift
//  MovieTrailers
//
//  Created by Dwayne Lewis on 11/13/18.
//  Copyright © 2018 Dwayne Lewis. All rights reserved.
//

import Foundation

// model for movies example name and imagename
struct Movie {
    var movieId: String = ""
    var name: String = ""
    var imageName: String = ""
    var description: String  = ""
    var backdrop_path: String = ""
    
    //initialize  values
    init(movieId: String, name:String, imageName:String, description:String, backdrop_path: String) {
        
        self.movieId = movieId
        self.name = name
        self.imageName = imageName
        self.description = description
        self.backdrop_path = backdrop_path
        
    }
    
}
