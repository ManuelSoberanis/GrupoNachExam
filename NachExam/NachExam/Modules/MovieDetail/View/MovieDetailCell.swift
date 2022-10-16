//
//  MovieDetailCell.swift
//  NachExam
//
//  Created by Manuel Soberanis on 16/10/22.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    static let identifier: String = "movieDetailCell"
    //MARK: - Components
    let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let movieHeader : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    let movieTitleLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    let runtimeLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let runTimerContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

//    let releaseLabel : UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.adjustsFontForContentSizeCategory = true
//        label.numberOfLines = 1
//        label.textAlignment = .left
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.text = "Fecha de estreno:"
//        return label
//    }()
//
//    let releaseValue : UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.adjustsFontForContentSizeCategory = true
//        label.numberOfLines = 1
//        label.textAlignment = .left
//        label.textColor = .white
//        return label
//    }()
    
    let rateLblContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let rateLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var rateImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .yellow
        iv.image = UIImage(systemName: "star.fill")
        return iv
    }()
    
    let generosValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let desctipcionLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()


    let bottomView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    let separatorValue : CGFloat = 10

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupViews()
    }

    //MARK: - Layout
    func setupViews(){
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        containerView.addSubview(movieHeader)
        movieHeader.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        movieHeader.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        movieHeader.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true

        containerView.addSubview(runTimerContainer)
        containerView.addSubview(runtimeLbl)
        runtimeLbl.trailingAnchor.constraint(equalTo: movieHeader.trailingAnchor, constant: -10).isActive = true
//        runtimeLbl.bottomAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: -5).isActive = true
     
        
        runTimerContainer.topAnchor.constraint(equalTo: runtimeLbl.topAnchor, constant: -5).isActive = true
        runTimerContainer.leadingAnchor.constraint(equalTo: runtimeLbl.leadingAnchor, constant: -5).isActive = true
        runTimerContainer.trailingAnchor.constraint(equalTo: runtimeLbl.trailingAnchor, constant: 5).isActive = true
        runTimerContainer.bottomAnchor.constraint(equalTo: runtimeLbl.bottomAnchor, constant: 5).isActive = true
        
        containerView.addSubview(rateLblContainer)
//        rateLblContainer.topAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: separatorValue).isActive = true
        rateLblContainer.leadingAnchor.constraint(equalTo: movieHeader.leadingAnchor, constant: 10).isActive = true
        rateLblContainer.bottomAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: -5).isActive = true
        
        runtimeLbl.centerYAnchor.constraint(equalTo: rateLblContainer.centerYAnchor).isActive = true
        
        rateLblContainer.addSubview(rateLbl)
        rateLblContainer.addSubview(rateImageView)
        
        rateImageView.topAnchor.constraint(equalTo: rateLblContainer.topAnchor, constant: 5).isActive = true
        rateImageView.leadingAnchor.constraint(equalTo: rateLblContainer.leadingAnchor, constant: 5).isActive = true
//        rateImageView.trailingAnchor.constraint(equalTo: rateLblContainer.trailingAnchor, constant: -3).isActive = true
        rateImageView.bottomAnchor.constraint(equalTo: rateLblContainer.bottomAnchor, constant: -5).isActive = true
        rateImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        rateImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        rateLbl.topAnchor.constraint(equalTo: rateLblContainer.topAnchor, constant: 0).isActive = true
        rateLbl.leadingAnchor.constraint(equalTo: rateImageView.trailingAnchor, constant: 5).isActive = true
        rateLbl.trailingAnchor.constraint(equalTo: rateLblContainer.trailingAnchor, constant: -5).isActive = true
        rateLbl.bottomAnchor.constraint(equalTo: rateLblContainer.bottomAnchor).isActive = true
      
        containerView.addSubview(generosValue)
        generosValue.topAnchor.constraint(equalTo: movieHeader.bottomAnchor, constant: 5).isActive = true
        generosValue.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        generosValue.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        
        containerView.addSubview(movieTitleLbl)
        movieTitleLbl.topAnchor.constraint(equalTo: generosValue.bottomAnchor, constant: 10).isActive = true
        movieTitleLbl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        movieTitleLbl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true

        
        containerView.addSubview(desctipcionLbl)
        desctipcionLbl.topAnchor.constraint(equalTo: movieTitleLbl.bottomAnchor, constant: 20).isActive = true
        desctipcionLbl.leadingAnchor.constraint(equalTo: movieTitleLbl.leadingAnchor).isActive = true
        desctipcionLbl.trailingAnchor.constraint(equalTo: movieTitleLbl.trailingAnchor).isActive = true

        containerView.addSubview(bottomView)
        bottomView.topAnchor.constraint(equalTo: desctipcionLbl.bottomAnchor, constant: 10).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    func configureView(title: String?, date: String?, moviePoster: String?, movieResults : MovieDetail?){
        let movieDetail = movieResults
        movieTitleLbl.text = title
        runtimeLbl.text = "\(movieDetail?.runtime ?? 0 ) min"
//        releaseValue.text = date
        let rateString = String(format: "%.1f", movieDetail?.vote_average ?? 0.0)
        rateLbl.text = rateString
        desctipcionLbl.text = movieDetail?.overview
        let poster = K.EndPoints.MovieServer.moviePosterPath + (moviePoster ?? "")
        movieHeader.sd_setImage(with: URL(string: poster), placeholderImage: UIImage(named: "watame"))
        guard let genres = movieDetail?.genres else {return}
        var generosName : [String] = []
        generosName.removeAll()
        for genre in genres {
            generosName.append(genre.name ?? "")
        }
        generosValue.text = generosName.joined(separator: ", ")
    }
    
    func setGenreArray(genre: [String]) {
        generosValue.text = genre.joined(separator: ", ")
    }
    
    func setPosterImage(posterImage : UIImage){
        self.movieHeader.image = posterImage
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}// end

