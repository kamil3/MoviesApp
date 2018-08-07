//
//  RequestRouter.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import Alamofire

enum RequestRouter: URLRequestConvertible {
    case topRatedMovies
    case popularMovies
    
    static let baseURLString = ""
    
    var method: HTTPMethod {
        switch self {
        case .topRatedMovies, .popularMovies:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .topRatedMovies:
            return "top_rated"
        case .popularMovies:
            return "popular"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RequestRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        let fixedParameters: [String: Any] = ["language": Locale.current.languageCode ?? "en", "api_key": ""]

        switch self {
            case .topRatedMovies, .popularMovies:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: fixedParameters)
        }
        
        return urlRequest
    }
}
