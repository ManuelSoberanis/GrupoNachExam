//
//  MovieDetailInteractor.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import Foundation

protocol MovieDetailInteractorProtocol {
    
    var presenter: MovieDetailPresenterProtocol? {get set}
    
    func fetchMovieDetail(with movieId: Int)
    
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    var presenter: MovieDetailPresenterProtocol?
    
    func fetchMovieDetail(with movieId: Int) {
        Movie.fetchMovieDetal(id: movieId) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let movieDetail):
                self.presenter?.didFetchMovieDetail(with: .success(movieDetail))
            case .failure(let error):
                print(error.localizedDescription)
                self.presenter?.didFetchMovieDetail(with: .failure(error))
            }
        }
    }
}
