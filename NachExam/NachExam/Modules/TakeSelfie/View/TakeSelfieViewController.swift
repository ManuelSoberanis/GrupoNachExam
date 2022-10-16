//
//  TakeSelfieViewController.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import UIKit

protocol TakeSelfieViewProtocol {
    var presenter: TakeSelfiePresenterProtocol? {get set}
    
    func userHasSelfie(image: UIImage?)
    
}

class TakeSelfieViewController: UIViewController {

    var presenter: TakeSelfiePresenterProtocol?
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    lazy var selfieImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.tintColor = .white
        return iv
    }()
    
    lazy var takeSelfieBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitleColor(.darkGray, for: .disabled)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.setTitle("Tomar selfie", for: .normal)
        btn.setTitle("Volver a tomar selfie", for: .selected)
        btn.isSelected = false
        btn.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
//        btn.isEnabled = false
        return btn
    }()
    
    lazy var dismissViewBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.setTitle("Aceptar", for: .normal)
        btn.isSelected = false
        btn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(containerView)
        view.backgroundColor = UIColor(named: "backgroundTint")
        setupContainerView()
        presenter?.checkForSelfie()
    }
    
    func setupContainerView() {
        
        containerView.addSubview(selfieImageView)
        containerView.addSubview(takeSelfieBtn)
        containerView.addSubview(dismissViewBtn)
        
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -50).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        NSLayoutConstraint.activate([
            selfieImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            selfieImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            selfieImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            selfieImageView.widthAnchor.constraint(equalToConstant: 200),
            selfieImageView.heightAnchor.constraint(equalToConstant: 200),
            
            takeSelfieBtn.topAnchor.constraint(equalTo: selfieImageView.bottomAnchor, constant: 15),
            takeSelfieBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            takeSelfieBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            
            
            dismissViewBtn.topAnchor.constraint(equalTo: takeSelfieBtn.bottomAnchor, constant: 10),
            dismissViewBtn.leadingAnchor.constraint(equalTo: takeSelfieBtn.leadingAnchor, constant: 0),
            dismissViewBtn.trailingAnchor.constraint(equalTo: takeSelfieBtn.trailingAnchor, constant: 0),
            dismissViewBtn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
        ])
        selfieImageView.layer.cornerRadius = 100
    }
    
    @objc func dismissView(){
        presenter?.didTapTakeSelfie(image: selfieImageView.image)
    }
    
    @objc func openCamera(){
#if targetEnvironment(simulator)
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
//        imagePicker.cameraCaptureMode
        present(imagePicker, animated: true, completion: nil)
#else
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
#endif
    }
    
}

extension TakeSelfieViewController: TakeSelfieViewProtocol {
    
    func userHasSelfie(image: UIImage?) {
        if image == nil {
            selfieImageView.image = UIImage(systemName: "person.circle.fill")
            self.takeSelfieBtn.isSelected = false
        } else {
            selfieImageView.image = image
            self.takeSelfieBtn.isSelected = true
        }
    }
}

extension TakeSelfieViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            self.takeSelfieBtn.isSelected = false
            return
        }
        selfieImageView.image = image
        self.takeSelfieBtn.isSelected = true
        picker.dismiss(animated: true, completion: nil)
       
    }
}
