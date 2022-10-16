//
//  MovieDetailViewController.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import UIKit

protocol MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol? {get set}
    func displayMovieDetail()
}

class MovieDetailViewController: UIViewController {

    private lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.delegate = self
        tv.dataSource = self
        tv.register( MovieDetailCell.self, forCellReuseIdentifier:  MovieDetailCell.identifier)
        tv.contentInsetAdjustmentBehavior = .never
        return tv
    }()
    
    private lazy var dismissViewBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .black
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return btn
    }()
    
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        view.addSubview(tableView)
        view.addSubview(dismissViewBtn)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        dismissViewBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dismissViewBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        dismissViewBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dismissViewBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dismissViewBtn.layer.cornerRadius = 25
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func dismissView(){
        presenter?.didTapDismissView()
    }

}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func displayMovieDetail() {
        tableView.reloadData()
    }
}

extension MovieDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.identifier, for: indexPath) as! MovieDetailCell
        cell.selectionStyle = .none
        let movieResult = presenter?.getMovieResult()
//        cell.movieHeader.image = posterImages
//        cell.movieTitle.text = self.movieTitle
//        cell.runtimeValue.text = "\(movieDetail.runtime!) min"
//        cell.releaseValue.text = self.date
//        cell.calificacionValue.text = "\(movieDetail.vote_average!)"
//        cell.generosValue.text = genreArray.joined(separator: ", ")
//        cell.desctipcionValue.text = movieDetail.overview
        cell.configureView(title: movieResult?.title ?? "", date: movieResult?.release_date ?? "", moviePoster: movieResult?.poster_path ?? "", movieResults: presenter?.getMovieDetail())
//        cell.setGenreArray(genre: presenter!.getGenre())
//        cell.setPosterImage(posterImage: presenter.getPosterImage())
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
