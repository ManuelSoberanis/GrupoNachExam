//
//  MovieListInteractor.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import Foundation

protocol MovieListInteractorProtocol {
    var presenter : MovieListPresenterProtocol? {get set}
    
    func getMoviesListData()
    
}

class MovieListInteractor: MovieListInteractorProtocol {
    
    var presenter: MovieListPresenterProtocol?
    
    func getMoviesListData() {
        Movie.fetchMovies { (result) in
            switch result {
            case .success(let movies):
                self.presenter?.didFetchMovies(with: .success(movies))
            case.failure(let error):
                self.presenter?.didFetchMovies(with: .failure(error))
            }
        }
    }
   
}
