//
//  HomePresenter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import Foundation
import UIKit

protocol HomePresenterProtocol {
    
    var interactor: HomeInteractorProtocol? {get set}
    var view : HomeViewProtocol? {get set}
    var router: HomeRouterProtocol? {get set}
    
    func setupView()
    func didTapGoToSelfieView(with image: UIImage?)
    func displayUserImage(image: UIImage?)
    func didTapGoToMoviesList()
    func didTapGoToMapView()
    func didTapSendImage(image: UIImage?, name: String?)
    func didSendImage(with result: Result<UIImage, Error>)
    
}

class HomePresenter: HomePresenterProtocol {
    
    var interactor: HomeInteractorProtocol?
    
    var view: HomeViewProtocol?
    
    var router: HomeRouterProtocol?
 
    func didTapGoToSelfieView(with image: UIImage?) {
        router?.presentTakeSelfieView(with: image)
    }
    
    func displayUserImage(image: UIImage?) {
        view?.userImageUpdated(image: image)
    }
    
    func didTapGoToMoviesList() {
        router?.goToMoviesList()
    }
    
    func didTapGoToMapView() {
        router?.goToMapView()
    }
    
    func didSendImage(with result: Result<UIImage, Error>) {
        switch result {
        case .success(_):
            view?.imageWasSent()
        default:
            break
        }
    }
    
    func didTapSendImage(image: UIImage?, name: String?) {
        interactor?.sendImageToFB(image: image, name: name)
    }
    
    func setupView() {
        view?.setupView()
    }
    
}
