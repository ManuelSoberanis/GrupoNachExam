//
//  MapViewController.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import UIKit
import CoreLocation
import MapKit
import Firebase

protocol MapViewProtocol {
    
    var presenter: MapPresenterProtocol? {get set}
    
    func displayLocations(with dataSnapshot: [DataSnapshot])
    func setupView()
    func userNameAdded(name: String)
}

class MapViewController: UIViewController {
    
    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.showsUserLocation = true
        return mv
    }()

    var presenter: MapPresenterProtocol?
    
    let locationManager = CLLocationManager()
    private var firstLat: CLLocationDegrees?
    private var firstLong: CLLocationDegrees?
    var userName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setupView()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
//
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
        presenter?.removeFBObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert()
    }
    
    func setupMapView(){
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showAlert(){
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Escribe tu nombre", message: "Esribe tu nombre para poder interactuar con el mapa.", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Nombre..."
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Aceptar", style: .default) { action in
            if let text = textField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
                self.presenter?.addUserName(name: textField.text!)
            } else {
                self.showAlert()
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
 
}

extension MapViewController: MapViewProtocol {
    func userNameAdded(name: String) {
       
        presenter?.getLocation()
        self.userName = name
        presenter?.updateUserLocation(with: userName, lat: firstLat ?? 0.0, long: firstLong ?? 0.0)
    }

    func setupView() {
        view.backgroundColor = .red
        
        setupMapView()
        
    }
    
    func displayLocations(with dataSnapshot: [DataSnapshot]) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        for snap in dataSnapshot {
            if let snapValue = snap.value as? [String: Any]{
                guard let lat = snapValue["latitude"] as? NSNumber else {return}
                guard let long = snapValue["longitude"] as? NSNumber else {return}
                let pin = MKPointAnnotation()
                pin.title = snap.key
                let coordinate = CLLocationCoordinate2D(latitude: Double(truncating: lat), longitude: Double(truncating: long))
                pin.coordinate = coordinate
                self.mapView.addAnnotation(pin)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.firstLat = location.coordinate.latitude
            self.firstLong = location.coordinate.longitude
            if userName != "" {
                presenter?.updateUserLocation(with: userName, lat: location.coordinate.latitude, long: location.coordinate.longitude)
            } else {
                render(with: location)
            }
        }
    }
    
    func render(with userLocation: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}

