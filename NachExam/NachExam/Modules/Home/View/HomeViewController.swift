//
//  HomeViewController.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import UIKit
import Firebase
import FirebaseStorage

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? {get set}
    
    func userImageUpdated(image: UIImage?)
    
    func imageWasSent()
    
    func setupView()
}

class HomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tv.separatorStyle = .none
        tv.backgroundColor = .black
        tv.contentInsetAdjustmentBehavior = .never
        return tv
    }()
    
    lazy var sendUserDataBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.darkGray, for: .disabled)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.setTitle("Enviar datos", for: .normal)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return btn
    }()
    
    var presenter: HomePresenterProtocol?
    weak var image: UIImage?
    private var userName: String?
    var spinner = UIActivityIndicatorView(style: .large)
    var loadingView: UIView = UIView()
    let headerItems = ["Escribe tu nombre","¡Tómate una selfie!","¡Checa la lista de películas!", "¡Checa el mapa!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .darkContent
      }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSendBtn()
    }
    
    private lazy var onNameChanged: (_ userName: String) -> Void = { [weak self] (userName) in
        guard let self = self else { return }
        if !userName.trimmingCharacters(in: .whitespaces).isEmpty{
            self.sendUserDataBtn.isEnabled = true
            self.sendUserDataBtn.backgroundColor = .white
        } else {
            self.sendUserDataBtn.isEnabled = false
            self.sendUserDataBtn.backgroundColor = .lightGray
        }
        self.userName = userName
    }
    
    @objc func saveData(){
        showActivityIndicator()
        presenter?.didTapSendImage(image: image, name: userName)
       
    }
    
    func setupSendBtn(){
        self.view.addSubview(sendUserDataBtn)
        NSLayoutConstraint.activate([
            sendUserDataBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            sendUserDataBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            sendUserDataBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = .white
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10

            self.spinner = UIActivityIndicatorView(style: .large)
            self.spinner.color = .black
            self.spinner.tintColor = .black
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)

            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
    func showAlert(){
    
        let alert = UIAlertController(title: "¡Datos enviados!", message: "", preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Ok", style: .default) { action in
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeViewProtocol {
    func setupView() {
        view.backgroundColor = .black
        view.addSubview(tableView)
        
        UINavigationBar.appearance().largeTitleTextAttributes =
        [.foregroundColor: UIColor.white]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.largeContentTitle = "Grupo Nach"
        navigationItem.title = "Grupo Nach"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.barTintColor = .white
        
          NSLayoutConstraint.activate([
              tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
              tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
              tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
              tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
          ])
        
        hideKeyboardWhenTappedAround()
    }
    func imageWasSent() {
        showAlert()
        self.userName = ""
        self.image = nil
        self.sendUserDataBtn.isEnabled = false
        self.sendUserDataBtn.backgroundColor = .lightGray
        self.hideActivityIndicator()
        self.tableView.reloadData()
    }

    func userImageUpdated(image: UIImage?) {
        self.image = image
        tableView.reloadData()
        
        if let userName = self.userName, !userName.trimmingCharacters(in: .whitespaces).isEmpty {
            self.sendUserDataBtn.isEnabled = true
            self.sendUserDataBtn.backgroundColor = .white
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = true
        cell.bind(with: indexPath.section, image: image, userName: self.userName)
        cell.nameCallback = onNameChanged
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            presenter?.didTapGoToSelfieView(with: image)
        case 2:
            presenter?.didTapGoToMoviesList()
        case 3:
            presenter?.didTapGoToMapView()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        lazy var headerLbl = UILabel()
        headerLbl.textColor = .lightGray
        view.addSubview(headerLbl)
        headerLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            headerLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            headerLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -3),
        ])
        headerLbl.text = headerItems[section]
        return view
    }

}
