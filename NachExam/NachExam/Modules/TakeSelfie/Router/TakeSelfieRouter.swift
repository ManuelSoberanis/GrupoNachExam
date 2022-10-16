//
//  TakeSelfieRouter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import Foundation
import UIKit

protocol SelfieImageTakenDelegate: AnyObject {
    func imageTaken(image: UIImage?)
}

protocol TakeSelfieRouterProtocol {
    static func build(with image: UIImage?, delegate: SelfieImageTakenDelegate?) -> UIViewController
    
    func didTakeImage(image: UIImage?)
}

class TakeSelfieRouter: TakeSelfieRouterProtocol {
    
    weak var viewController: UIViewController?
    weak var delegate : SelfieImageTakenDelegate?
    
    static func build(with image: UIImage?, delegate: SelfieImageTakenDelegate? = nil) -> UIViewController {
        let view = TakeSelfieViewController()
        let interactor = TakeSelfieInteractor()
        let presenter = TakeSelfiePresenter(image: image)
        let router = TakeSelfieRouter()

        view.presenter = presenter

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router

        interactor.presenter = presenter

//        router.presenter = presenter
        router.viewController = view
        router.delegate = delegate
        
        return view
    }
   
    func didTakeImage(image: UIImage?) {
        self.delegate?.imageTaken(image: image)
        self.viewController?.dismiss(animated: true)
    }
}
