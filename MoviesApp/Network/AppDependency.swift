//
//  AppDependency.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 08.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

protocol HasMovieServiceProtocol {
    var movieService: MovieServiceProtocol { get }
}

struct AppDependency: HasMovieServiceProtocol {
    let movieService: MovieServiceProtocol
}
