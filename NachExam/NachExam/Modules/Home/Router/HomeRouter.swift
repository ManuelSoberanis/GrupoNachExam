//
//  HomeRouter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import UIKit

protocol HomeRouterProtocol {
    
    static func build() -> UIViewController
    
    func presentTakeSelfieView(with image: UIImage?)
    
    func goToMoviesList()
    
    func goToMapView()
}

class HomeRouter: HomeRouterProtocol {
    
    weak var viewController: UIViewController?
    var presenter : HomePresenterProtocol?
    static func build() -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()

        let navigation = UINavigationController(rootViewController: view)
        navigation.navigationBar.prefersLargeTitles = true
        view.presenter = presenter

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router

        interactor.presenter = presenter

        router.presenter = presenter
        router.viewController = view
        
        return navigation
    }
    
    func presentTakeSelfieView(with image: UIImage?) {
        let selfieViewRouter = TakeSelfieRouter.build(with: image, delegate: self)
        selfieViewRouter.modalPresentationStyle = .overCurrentContext
        selfieViewRouter.modalTransitionStyle = .crossDissolve
        self.viewController?.present(selfieViewRouter, animated: true)
    }
    
    func goToMoviesList() {
        let movieListVC = MovieListRouter.build()
        self.viewController?.navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    func goToMapView() {
        let mapRouter = MapRouter.build()
        self.viewController?.navigationController?.pushViewController(mapRouter, animated: true)
    }
    
}

extension HomeRouter: SelfieImageTakenDelegate {
    func imageTaken(image: UIImage?) {
        presenter?.displayUserImage(image: image)
    }
}
