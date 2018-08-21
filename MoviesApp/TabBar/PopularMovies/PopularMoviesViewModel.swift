//
//  PopularMoviesViewModel.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 08.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import RxSwift
import RxCocoa

struct PopularMoviesViewModel {
    typealias Dependencies = HasMovieServiceProtocol
    
    // MARK:- Outputs
    let popularMovies: Observable<[Movie]>
    let alertMessage: Observable<Error>
    
    // MARK:- Init
    init(with dependencies: Dependencies) {
        let _alertMessage = PublishSubject<Error>()
        self.alertMessage = _alertMessage.asObservable()
        
        //Retrieve movies from first page only (pagination is not used)
        let _popularMovies = dependencies.movieService.popularMovies()
            .map { paginatedMovie -> [Movie] in
                return paginatedMovie.results ?? []
            }
            .share(replay: 1, scope: .forever)
        
        let fetchedAlternativeMovieTitles = _popularMovies.flatMap { movies -> Observable<Observable<AlternativeMovieTitle>> in
            let movieTitlesObservableArray = movies.map { movie -> Observable<AlternativeMovieTitle> in
                    guard let movieId = movie.id else { return Observable.empty() }
                    return dependencies.movieService.alternativeMovieTitles(withMovieId: String(movieId))
            }
            return Observable.from(movieTitlesObservableArray)
        }
            .merge(maxConcurrent: 2) // only 2 sequences are subscribed at the same time
        
        //when a new alternativeMovieTitle arrives, there is a movie update using scan
        let updatedPopularMovies = _popularMovies.flatMap { popularMovies -> Observable<[Movie]> in
            return fetchedAlternativeMovieTitles.scan(popularMovies) { updatedMovies, alternativeMovieTitle in
                return updatedMovies.map { movie in
                    var mv = movie
                    guard let movieId = movie.id, let alternativeMovieTitleId = alternativeMovieTitle.id else { return mv }
                    if movieId == alternativeMovieTitleId {
                        mv.alternativeTitles = alternativeMovieTitle.titles ?? []
                    }
                    return mv
                }
            }
        }
        
        self.popularMovies = _popularMovies
            .concat(updatedPopularMovies) //reloading data on every update
            .catchError { error in
                _alertMessage.onNext(error)
                return Observable.just([])
            }
    }
}
