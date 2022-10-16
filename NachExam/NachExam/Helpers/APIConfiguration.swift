//
//  APIConfiguration.swift
//  TheMoviesMVP
//
//  Created by Manuel Soberanis on 23/09/20.
//  Copyright © 2020 Manuel Soberanis. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
