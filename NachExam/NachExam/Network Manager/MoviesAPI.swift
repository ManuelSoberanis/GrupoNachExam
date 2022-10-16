//
//  MoviesAPI.swift
//  TheMoviesMVP
//
//  Created by Manuel Soberanis on 23/09/20.
//  Copyright © 2020 Manuel Soberanis. All rights reserved.
//

import Foundation
import Alamofire

enum MoviesRouter: APIConfiguration {
    case fetchMovies
//    case fetchMoviePoster(poster_path : String) (No se me ocurre como hacer esta funcion aqui)
    case fetchMovieDetail(id: Int)
    
    var method: HTTPMethod {
        switch self {
        case .fetchMovies, .fetchMovieDetail:
            return .get
        }
    }

    var path: String {
        switch self {
        case .fetchMovies:
            return K.EndPoints.Movie.moviesList
            
        case .fetchMovieDetail(let id):
            return "/\(id)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchMovies, .fetchMovieDetail:
            return ["api_key": K.EndPoints.MovieServerParameters.api_key,
                    "language": K.EndPoints.MovieServerParameters.language,
                    "page": K.EndPoints.MovieServerParameters.page]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }

    
    func asURLRequest() throws -> URLRequest {
        do {
            
            //MARK: Test en caso de tener multiples links
            let urlPath : URL = {
                switch self {
                case .fetchMovies, .fetchMovieDetail:
                    return try! K.EndPoints.MovieServer.moviesURL.asURL()
                }
            }()
            
            var url = urlPath
            url.appendPathComponent(path)
            
            var urlRequest = try URLRequest(url: url, method: method)
            urlRequest = try encoding.encode(urlRequest, with: parameters)
            return urlRequest
        } catch {
            return URLRequest(url: URL(string: "")!)
        }
    }
    
}

extension Movie {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:MoviesRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                completion(response.result)
            }
    }
    
    static func fetchMovies(completion:@escaping (Result<Movie, AFError>)->Void){
        performRequest(route: MoviesRouter.fetchMovies, completion: completion)
    }
    
    
    static func fetchMovieDetal(id: Int, completion:@escaping (Result<MovieDetail, AFError>)->Void){
        performRequest(route: MoviesRouter.fetchMovieDetail(id: id), completion: completion)
    }
    
    
    //MARK: No se me ocurre como hacer el fetch de las imagenes desde aqui
//    static func getMoviePoster(poster_path: String, completion:@escaping (Result<Movie, AFError>)->Void){
//        performRequest(route: MoviesRouter.fetchMoviePoster(poster_path: poster_path), completion: completion)
//    }
    
}
