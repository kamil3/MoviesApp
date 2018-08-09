//
//  MovieService.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 08.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import RxSwift

protocol MovieServiceProtocol {
    func topRatedMovies() -> Observable<PaginatedMovie>
    func popularMovies() -> Observable<PaginatedMovie>
    func alternativeMovieTitles(withMovieId movieId: String) -> Observable<AlternativeMovieTitle>
}

struct MovieService: MovieServiceProtocol {
    private let apiClient: ApiClientProtocol
    
    init(with apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    // MARK:- MovieServiceProtocol
    func topRatedMovies() -> Observable<PaginatedMovie> {
        let requestRoute = RequestRouter.topRatedMovies
        return apiClient.convenientRequest(for: requestRoute)
    }
    
    func popularMovies() -> Observable<PaginatedMovie> {
        let requestRoute = RequestRouter.popularMovies
        return apiClient.convenientRequest(for: requestRoute)
    }
    
    func alternativeMovieTitles(withMovieId movieId: String) -> Observable<AlternativeMovieTitle> {
        let requestRoute = RequestRouter.alternativeTitles(movieId: movieId)
        return apiClient.convenientRequest(for: requestRoute)
    }
}
