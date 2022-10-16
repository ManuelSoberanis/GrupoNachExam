//
//  HomeInteractor.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

protocol HomeInteractorProtocol {
    
    var presenter: HomePresenterProtocol? {get set}
    
    func getData()
    
    func sendImageToFB(image: UIImage?, name: String?)
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
    
    
    func getData() {
        
    }
    
    func sendImageToFB(image: UIImage?, name: String?) {
        let firebaseSR = Storage.storage().reference()
        let firebaseDB = Firestore.firestore()
        
        guard let image = image, let userName = name else { return }
        if let imageData = image.jpegData(compressionQuality: 0.8){
            
            let imagePath = "images/\(userName).jpg"
            let fileRef = firebaseSR.child(imagePath)
            
            _ = fileRef.putData(imageData) { metadata, error in
                if error == nil && metadata != nil {
                    firebaseDB.collection("users").document(userName).setData([
                        "userName" : userName,
                        "imgUrl": imagePath
                    ])
                    self.presenter?.didSendImage(with: .success(UIImage()))
                } else {
                    self.presenter?.didSendImage(with: .failure(error!))
                }
            }
        }
    }
    
}
