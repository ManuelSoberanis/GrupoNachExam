//
//  TakeSelfiePresenter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import Foundation
import UIKit

protocol TakeSelfiePresenterProtocol {
    var interactor: TakeSelfieInteractorProtocol? {get set}
    var view : TakeSelfieViewProtocol? {get set}
    var router: TakeSelfieRouterProtocol? {get set}
    
    func didTapTakeSelfie(image: UIImage?)
    func checkForSelfie()
}

class TakeSelfiePresenter: TakeSelfiePresenterProtocol {
    
    var interactor: TakeSelfieInteractorProtocol?
    
    var view: TakeSelfieViewProtocol?
    
    var router: TakeSelfieRouterProtocol?
    
    let image : UIImage?
    
    init(image: UIImage?) {
        self.image = image
    }
    
    func checkForSelfie() {
        self.view?.userHasSelfie(image: image)
    }
    
    func didTapTakeSelfie(image: UIImage?) {
        self.router?.didTakeImage(image: image)
    }
   
}
