//
//  MapInteractor.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import Foundation
import Firebase
import CoreLocation

protocol MapInteractorProtocol{
    
    var presenter: MapPresenterProtocol? {get set}
    
    func fetchLocations()
    
    func sendRemoveFBObserver()
    
    func sendUpdateUserLocation(with name: String?, lat: CLLocationDegrees, long: CLLocationDegrees)
}

class MapInteractor: MapInteractorProtocol {
    
    var presenter: MapPresenterProtocol?
    
    var dbReference: DatabaseReference?
    
    func fetchLocations() {
        self.dbReference = Database.database().reference()
        
        self.dbReference?.child("UserLocation").child("Users").observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                self.presenter?.didFechtLocations(dataSnapshot: snapshot)
            }
        })
    }
    
    func sendRemoveFBObserver() {
        self.dbReference?.child("UserLocation").child("Users").removeAllObservers()
    }
    
    func sendUpdateUserLocation(with name: String?, lat: CLLocationDegrees, long: CLLocationDegrees) {
        self.dbReference?.child("UserLocation").child("Users").child(name ?? "").child("latitude").setValue(lat)
        self.dbReference?.child("UserLocation").child("Users").child(name ?? "").child("longitude").setValue(long)
    }
}
