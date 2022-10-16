//
//  MovieDetailRouter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import UIKit

protocol MovieDetailRouterProtocol {
    static func build(with movieId: MovieResult?) -> UIViewController
    
    func dismissView()
}

class MovieDetalRouter: MovieDetailRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build(with movie: MovieResult?) -> UIViewController {
        let view = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetalPresenter(movie: movie)
        let router = MovieDetalRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter

        router.viewController = view
        
        return view
    }
    
    func dismissView() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
}
