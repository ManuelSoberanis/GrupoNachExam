//
//  Constants.swift
//  TheMoviesMVP
//
//  Created by Manuel Soberanis on 23/09/20.
//  Copyright © 2020 Manuel Soberanis. All rights reserved.
//

import Foundation
struct K{
    
    enum EndPoints{
        
        enum MovieServer{
            static let moviesURL = "https://api.themoviedb.org/3/movie"
            static let moviePosterPath = "https://image.tmdb.org/t/p/w342"
        }
        
        enum MovieServerParameters{
            static let api_key = "634b49e294bd1ff87914e7b9d014daed"
            static let language = "es-ES"
            static let page = "1"
        }
        
        enum Movie{
            static let moviesList = "/now_playing"
        }
    }
}

enum HTTPHeaderField: String{
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String{
    case json = "application/json"
}
