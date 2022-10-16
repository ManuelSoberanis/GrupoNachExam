//
//  MapRouter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import UIKit

protocol MapRouterProtocol {
    static func build() -> UIViewController
}

class MapRouter: MapRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let view = MapViewController()
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter

        router.viewController = view
        
        return view
    }
    
}
