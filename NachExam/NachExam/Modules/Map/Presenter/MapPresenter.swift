//
//  MapPresenter.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import Foundation
import Firebase
import CoreLocation

protocol MapPresenterProtocol {
    var interactor: MapInteractorProtocol? {get set}
    var view : MapViewProtocol? {get set}
    var router: MapRouterProtocol? {get set}
    
    func getLocation()
    
    func setupView()
    
    func addUserName(name: String)
    
    func didFechtLocations(dataSnapshot: [DataSnapshot])
    
    func removeFBObserver()
    
    func updateUserLocation(with name: String?, lat: CLLocationDegrees, long: CLLocationDegrees )
}

class MapPresenter: MapPresenterProtocol {
    var interactor: MapInteractorProtocol?
    
    var view: MapViewProtocol?
    
    var router: MapRouterProtocol?
    
    func setupView() {
        view?.setupView()
    }
    
    func getLocation() {
        interactor?.fetchLocations()
    }

    func addUserName(name: String) {
        view?.userNameAdded(name: name)
    }
    
    func didFechtLocations(dataSnapshot: [DataSnapshot]) {
        view?.displayLocations(with: dataSnapshot)
    }
    
    func removeFBObserver() {
        interactor?.sendRemoveFBObserver()
    }
    
    func updateUserLocation(with name: String?, lat: CLLocationDegrees, long: CLLocationDegrees) {
        interactor?.sendUpdateUserLocation(with: name, lat: lat, long: long)
    }
}
