//
//  TopRatedMoviesViewModel.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 08.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

struct TopRatedMoviesViewModel {
    typealias Dependencies = HasMovieServiceProtocol
    let dependencies: Dependencies
    
    init(with dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
