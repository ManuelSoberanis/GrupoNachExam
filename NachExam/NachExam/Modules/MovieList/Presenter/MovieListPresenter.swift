//
//  MovieListPresenter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import Foundation

protocol MovieListPresenterProtocol {
    
    var interactor : MovieListInteractorProtocol? {get set}
    var view : MovieListViewProtocol? {get set}
    var router : MovieListRouterProtocol? {get set}
    
    func setupView()
    func didFetchMovies(with result: Result<Movie, Error>)
    func getRows() -> Int
    func getMovieAt(index: Int) -> MovieResult
    func didTapGoToMovieDetail(with movie: MovieResult?)
}

class MovieListPresenter: MovieListPresenterProtocol {

    var view: MovieListViewProtocol?
    
    var router: MovieListRouterProtocol?
    
    var interactor: MovieListInteractorProtocol? {
        didSet {
            interactor?.getMoviesListData()
        }
    }
    
    private var movieResult : [MovieResult] = []

    func didFetchMovies(with result: Result<Movie, Error>) {
        switch result {
        case .success(let movies):
            guard let moviesResults = movies.results else {return}
             view?.displayMovies(with: movies)
            self.movieResult = moviesResults
        default:
            break
        }
    }
    
    func didTapGoToMovieDetail(with movie: MovieResult?) {
        router?.goToMovieDetail(with: movie)
    }
    
    func getRows() -> Int {
        return self.movieResult.count
    }
    
    func getMovieAt(index: Int) -> MovieResult{
        return self.movieResult[index]
    }
    
    func setupView() {
        view?.setupView()
    }

}
