//
//  MovieDetalPresenter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    
    var interactor: MovieDetailInteractorProtocol? {get set}
    var view : MovieDetailViewProtocol? {get set}
    var router: MovieDetailRouterProtocol? {get set}
    
    func didFetchMovieDetail(with result: Result<MovieDetail, Error>)
    
    func getMovieResult() -> MovieResult?
    
    func getMovieDetail()-> MovieDetail
    
    func didTapDismissView()
}

class MovieDetalPresenter: MovieDetailPresenterProtocol {
    
    var interactor: MovieDetailInteractorProtocol? {
        didSet {
            interactor?.fetchMovieDetail(with: movie?.id ?? 0)
        }
    }
    
    var view: MovieDetailViewProtocol?
    
    var router: MovieDetailRouterProtocol?
    
    
    let movie : MovieResult?
    
    private var movieDetail = MovieDetail()
    
    init(movie: MovieResult?) {
        self.movie = movie
    }
    
    func didFetchMovieDetail(with result: Result<MovieDetail, Error>) {
        switch result {
        case .success(let movies):
            movieDetail = movies
            view?.displayMovieDetail()
        default:
            break
        }
    }
    
    func getMovieResult() -> MovieResult? {
        return self.movie
    }
    
    func getMovieDetail()-> MovieDetail{
        return movieDetail
    }
    
    func didTapDismissView() {
        router?.dismissView()
    }
    
}
