//
//  SortingMoviesType.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 23.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

enum SortingMoviesType: Int, CustomStringConvertible {
    case rate = 0
    case votes = 1
    
    var description: String {
        switch self {
        case .rate:
            return "top.rated.movies.segmented.control.rate".localized()
        case .votes:
            return "top.rated.movies.segmented.control.votes".localized()
        }
    }
}
