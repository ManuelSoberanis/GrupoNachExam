//
//  HomeTableViewCell.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    static let identifier : String = "homeCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    lazy var nameTF : UITextField = {
        let tf = UITextField()
        let placeHolderText = NSAttributedString(string: "Escribe tu nombre",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.background = UIColor.darkGray
        tf.tintColor = .white
        tf.textColor = .white
        tf.attributedPlaceholder = placeHolderText
        tf.isUserInteractionEnabled = true
        tf.isHidden = true
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private lazy var selfieContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .darkGray
//        view.layer.cornerRadius = 10
//        view.clipsToBounds = true
        return view
    }()
    
    lazy var selfieImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        iv.image = UIImage(systemName: "person.circle.fill")
        iv.isHidden = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var optionLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.isHidden = true
        return lbl
    }()
    
    lazy var arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "chevron.forward")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        iv.isHidden = true
        return iv
    }()
    
    var nameCallback: ((_ userName: String) -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellCViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(with section: Int, image: UIImage?, userName: String?){
    
        switch section {
        case 0:            
            nameTF.text = userName
            nameTF.isHidden = false
            nameTF.isUserInteractionEnabled = true
            optionLbl.isHidden = true
            arrowImageView.isHidden = true
            setupTFView()
        case 1:
            selfieImageView.isHidden = false
            selfieImageView.image = image
            if image == nil {
                selfieImageView.image = UIImage(systemName: "person.circle.fill")
            }
            setupSelfieView()
        case 2:
            optionLbl.text = "Ir a la lista de películas"
            optionLbl.isHidden = false
            arrowImageView.isHidden = false
            setupLastOptions()
        case 3:
            nameTF.isHidden = true
            nameTF.isUserInteractionEnabled = false
            optionLbl.text = "Ir al mapa"
            optionLbl.isHidden = false
            arrowImageView.isHidden = false
            setupLastOptions()
        default:
            break
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let string :String = textField.text!
        nameCallback?(string)
    }

}

extension HomeTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTF.resignFirstResponder()
        self.endEditing(true)
        return true
    }
    
}

extension HomeTableViewCell {
    
    func setupCellCViews(){
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    func setupTFView(){
        containerView.addSubview(nameTF)
        
        NSLayoutConstraint.activate([
            nameTF.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            nameTF.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            nameTF.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            nameTF.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            nameTF.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    func setupSelfieView(){
        
        containerView.addSubview(selfieContainer)
        selfieContainer.addSubview(selfieImageView)
        
        NSLayoutConstraint.activate([
            selfieContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            selfieContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            selfieContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            selfieContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            selfieImageView.topAnchor.constraint(equalTo: selfieContainer.topAnchor),
            selfieImageView.centerXAnchor.constraint(equalTo: selfieContainer.centerXAnchor),
            selfieImageView.bottomAnchor.constraint(equalTo: selfieContainer.bottomAnchor),
            selfieImageView.widthAnchor.constraint(equalToConstant: 100),
            selfieImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        selfieImageView.layer.cornerRadius = 50
    }
    
    func setupLastOptions(){
        
        containerView.addSubview(optionLbl)
        containerView.addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            optionLbl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            optionLbl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            optionLbl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            
            arrowImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            arrowImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
        
    }
    
}
