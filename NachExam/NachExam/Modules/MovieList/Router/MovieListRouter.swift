//
//  MovieListRouter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import Foundation
import UIKit

protocol MovieListRouterProtocol {
    static func build() -> UIViewController
    
    func goToMovieDetail(with movie: MovieResult?)
}

class MovieListRouter : MovieListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        
        let view = MovieListViewController()
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        let router = MovieListRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter

        router.viewController = view
        
        return view
    }
    
    func goToMovieDetail(with movie: MovieResult?) {
        let movieDetailtVC = MovieDetalRouter.build(with: movie)
//        selfieViewRouter.modalPresentationStyle = .overCurrentContext
//        selfieViewRouter.modalTransitionStyle = .crossDissolve
        self.viewController?.navigationController?.pushViewController(movieDetailtVC, animated: true)
    }
}

