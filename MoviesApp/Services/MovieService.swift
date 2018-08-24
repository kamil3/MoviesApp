//
//  MovieService.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 08.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import RxSwift

protocol MovieServiceProtocol {
    func topRatedMovies() -> Observable<[Movie]>
    func popularMovies() -> Observable<[Movie]>
    func alternativeMovieTitles(withMovieId movieId: String) -> Observable<AlternativeMovieTitle>
}

struct MovieService: MovieServiceProtocol {
    private let movieNetworkService: MovieNetworkServiceProtocol
    private let moviePersistenceManager: MoviePersistenceManagerProtocol
    
    init(with movieNetworkService: MovieNetworkServiceProtocol, moviePersistenceManager: MoviePersistenceManagerProtocol) {
        self.movieNetworkService = movieNetworkService
        self.moviePersistenceManager = moviePersistenceManager
    }
    
    // MARK:- MovieServiceProtocol
    func topRatedMovies() -> Observable<[Movie]> {
        return movieNetworkService.topRatedMovies()
            .map { paginatedMovie -> [Movie] in
                let movies = paginatedMovie.results ?? []
                return movies.map { movie in
                    var mv = movie
                    mv.type = .top_rated
                    return mv
                }
            }
    }
    
    func popularMovies() -> Observable<[Movie]> {
        return movieNetworkService.popularMovies()
            .map { paginatedMovie -> [Movie] in
                let movies = paginatedMovie.results ?? []
                return movies.map { movie in
                    var mv = movie
                    mv.type = .popular
                    return mv
                }
        }
    }
    
    func alternativeMovieTitles(withMovieId movieId: String) -> Observable<AlternativeMovieTitle> {
        return movieNetworkService.alternativeMovieTitles(withMovieId: movieId)
    }
}
