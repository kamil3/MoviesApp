//
//  MovieServiceMock.swift
//  MoviesAppTests
//
//  Created by Kamil Waszkiewicz on 27.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import RxSwift
@testable import MoviesApp

struct MovieServiceMock: MovieServiceProtocol {
    var moviesReturnValue: Observable<[Movie]> = .empty()
    var alternativeMovieTitlesReturnValue: Observable<AlternativeMovieTitle> = .empty()
    
    func topRatedMovies() -> Observable<[Movie]> {
        return moviesReturnValue
    }
    
    func popularMovies() -> Observable<[Movie]> {
        return moviesReturnValue
    }
    
    func alternativeMovieTitles(withMovieId movieId: String) -> Observable<AlternativeMovieTitle> {
        return alternativeMovieTitlesReturnValue
    }
}
