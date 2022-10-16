//
//  MovieListViewController.swift
//  NachExam
//
//  Created by Manuel Soberanis on 15/10/22.
//

import UIKit

protocol MovieListViewProtocol {
    var presenter: MovieListPresenterProtocol? {get set}
    
    func setupView()
    func displayMovies(with movies: Movie)
    
    
}

class MovieListViewController: UIViewController {

    private lazy var collectionView : UICollectionView = {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth/2, height: ((screenWidth/2) * 1.51098))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(MovieListCVCell.self, forCellWithReuseIdentifier: MovieListCVCell.identifier)
        return cv
    }()
    
    var presenter: MovieListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.setupView()
    }
   
}

extension MovieListViewController: MovieListViewProtocol {
    func setupView() {
        self.view.backgroundColor = .black
        
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
        self.navigationController?.navigationBar.largeContentTitle = "Películas Nach"
        navigationItem.title = "Películas"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.barTintColor = .white
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    
    func displayMovies(with movies: Movie) {
        collectionView.reloadData()
    }

}

extension MovieListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCVCell.identifier, for: indexPath) as! MovieListCVCell
        movieCell.backgroundColor = .clear
        movieCell.configureView(movieResults: presenter?.getMovieAt(index: indexPath.row))
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resultRow = presenter?.getMovieAt(index: indexPath.row)
        presenter?.didTapGoToMovieDetail(with: resultRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let width = screenWidth / 2
        let height = width * 1.51098
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    

    
    
}//end
