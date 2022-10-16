//
//  TakeSelfieInteractor.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import Foundation

protocol TakeSelfieInteractorProtocol {
    var presenter: TakeSelfiePresenterProtocol? {get set}
}

class TakeSelfieInteractor: TakeSelfieInteractorProtocol {
    var presenter: TakeSelfiePresenterProtocol?
    
}
