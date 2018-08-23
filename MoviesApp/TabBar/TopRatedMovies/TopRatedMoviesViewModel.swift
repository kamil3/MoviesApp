//
//  TopRatedMoviesViewModel.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 08.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import RxSwift
import Action

struct TopRatedMoviesViewModel {
    typealias Dependencies = HasMovieServiceProtocol
    
    // MARK:- Outputs
    let topRatedMovies: Observable<[Movie]>
    let alertMessage: Observable<Error>
    let activityIndicator: ActivityIndicator
    
    // MARK:- Inputs
    let reload: AnyObserver<Void>
    
    init(with dependencies: Dependencies) {
        let _reload = BehaviorSubject<Void>(value: ())
        self.reload = _reload.asObserver()
        
        let _activityIndicator = ActivityIndicator()
        self.activityIndicator = _activityIndicator
        
        let _alertMessage = PublishSubject<Error>()
        self.alertMessage = _alertMessage.asObservable()
        
        self.topRatedMovies = _reload.flatMap { _ -> Observable<[Movie]> in
            dependencies.movieService.topRatedMovies()
                .map { paginatedMovie -> [Movie] in
                    return paginatedMovie.results ?? []
                }
                .trackActivity(_activityIndicator)
                .catchError { error in
                    _alertMessage.onNext(error)
                    return Observable.empty()
            }
        }
    }
}
