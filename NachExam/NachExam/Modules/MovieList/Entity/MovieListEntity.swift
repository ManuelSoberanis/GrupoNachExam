//
//  MovieListEntity.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import Foundation

struct Movie: Decodable {
    let results : [MovieResult]?
}

struct MovieResult : Decodable {
    let id : Int?
    let title : String?
    let poster_path : String?
    let vote_average : Float?
    let release_date : String?
}
