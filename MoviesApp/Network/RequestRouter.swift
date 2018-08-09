//
//  RequestRouter.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import Alamofire
import SwinjectStoryboard

enum RequestRouter: URLRequestConvertible {
    case topRatedMovies
    case popularMovies
    case alternativeTitles(movieId: String)
    
    static let baseURLString = SwinjectStoryboard.defaultContainer.resolve(AppConfig.self)!.baseURL
    static let apiKey = SwinjectStoryboard.defaultContainer.resolve(AppConfig.self)!.apiKey
    
    var method: HTTPMethod {
        switch self {
        case .topRatedMovies, .popularMovies, .alternativeTitles:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .topRatedMovies:
            return "movie/top_rated"
        case .popularMovies:
            return "movie/popular"
        case .alternativeTitles(let movieId):
            return "movie/\(movieId)/alternative_titles"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RequestRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        let fixedParameters: [String: Any] = ["language": Locale.current.languageCode ?? "en", "api_key": RequestRouter.apiKey]

        switch self {
            case .topRatedMovies, .popularMovies, .alternativeTitles:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: fixedParameters)
        }
        
        return urlRequest
    }
}
