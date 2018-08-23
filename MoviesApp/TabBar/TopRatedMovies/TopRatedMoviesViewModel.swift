//
//  TopRatedMoviesViewModel.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 08.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

struct TopRatedMoviesViewModel {
    typealias Dependencies = HasMovieServiceProtocol
    
    // MARK:- Outputs
    let sortedMovies: Observable<[Movie]>
    let alertMessage: Observable<Error>
    let activityIndicator: ActivityIndicator
    
    // MARK:- Inputs
    let reload: AnyObserver<Void>
    let selectedSegmentIndex: AnyObserver<Int>
    
    init(with dependencies: Dependencies) {
        let _reload = BehaviorSubject<Void>(value: ())
        self.reload = _reload.asObserver()
        
        let _activityIndicator = ActivityIndicator()
        self.activityIndicator = _activityIndicator
        
        let _alertMessage = PublishSubject<Error>()
        self.alertMessage = _alertMessage.asObservable()
        
        let _selectedSegmentIndex = PublishSubject<Int>()
        self.selectedSegmentIndex = _selectedSegmentIndex.asObserver()
        
        let _topRatedMovies = _reload.flatMap { _ -> Observable<[Movie]> in
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
        
        let sortingMoviesType = _selectedSegmentIndex.map { SortingMoviesType.init(rawValue: $0) ?? .rate }
        self.sortedMovies = Observable.combineLatest(sortingMoviesType, _topRatedMovies).map { type, movies -> [Movie] in
            let sortedMovies = movies.sorted { movie1, movie2 in
                switch type {
                case .rate:
                    return movie1.voteAverage ?? 0 > movie2.voteAverage ?? 0
                case .votes:
                    return movie1.voteCount ?? 0 > movie2.voteCount ?? 0
                }
            }
            return sortedMovies
        }
    }
}
