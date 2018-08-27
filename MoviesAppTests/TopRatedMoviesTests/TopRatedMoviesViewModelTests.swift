//
//  TopRatedMoviesViewModelTests.swift
//  MoviesAppTests
//
//  Created by Kamil Waszkiewicz on 27.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
@testable import MoviesApp

class TopRatedMoviesViewModelTests: XCTestCase {

    let topRatedMovie = Movie.create(id: 1)
    
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    let movieService = MovieServiceMock()
    var viewModelUnderTest: TopRatedMoviesViewModel!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        let topRatedMoviesViewModelDependencies = TopRatedMoviesViewModelDependencies(movieService: movieService, rxReachabilitySerivce: RxReachabilityServiceMock())
        viewModelUnderTest = TopRatedMoviesViewModel(with: topRatedMoviesViewModelDependencies)
    }
    
    override func tearDown() {
        viewModelUnderTest = nil
        super.tearDown()
    }
    
    func test_topRatedMovies_returnsValidObjects() {
        movieService.moviesReturnValue = .just([topRatedMovie])
        
        testScheduler.createHotObservable([next(300, ())])
            .bind(to: viewModelUnderTest.reload)
            .disposed(by: disposeBag)
        
        testScheduler.createHotObservable([next(400, (0))])
            .bind(to: viewModelUnderTest.selectedSegmentIndex)
            .disposed(by: disposeBag)
                
        let result = testScheduler.start { self.viewModelUnderTest.sortedMovies }
        XCTAssertEqual(result.events.count, 1)
        
        guard let movie = result.events.first?.value.element?.first else {
            return XCTFail()
        }
        
        XCTAssertEqual(movie.id, 1)
    }
}

private struct TopRatedMoviesViewModelDependencies: HasMovieServiceProtocol, HasRxReachabilityServiceProtocol {
    let movieService: MovieServiceProtocol
    let rxReachabilitySerivce: RxReachabilitySerivceProtocol
}
