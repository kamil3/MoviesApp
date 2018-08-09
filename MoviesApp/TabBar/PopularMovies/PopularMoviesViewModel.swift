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
        self.popularMovies = dependencies.movieService.popularMovies()
            .map { paginatedMovie -> [Movie] in
                return paginatedMovie.results ?? []
            }
            .catchError { error in
                _alertMessage.onNext(error)
                return Observable.just([])
            }
    }
}
