//
//  MovieDetailEntity.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import Foundation

struct MovieDetail : Decodable {
    let backdrop_path : String?
    let runtime : Int?
    let overview : String?
    let vote_average : Float?
    let genres: [Genres]?
    
    //Need init?, thx medium
    init() {
        self.backdrop_path = ""
        self.genres = [Genres]()
        self.runtime = 0
        self.overview = ""
        self.vote_average = 0.0
    }
}

struct Genres : Decodable {
    let id : Int?
    let name: String?
}
