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
import Action
@testable import MoviesApp

class TopRatedMoviesViewModelTests: XCTestCase {

    let topRatedMovie = Movie.create(id: 1)
    
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    let movieService = MovieServiceMock()
    let rxReachabilitySerivce = RxReachabilityServiceMock()
    var viewModelUnderTest: TopRatedMoviesViewModel!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        let topRatedMoviesViewModelDependencies = TopRatedMoviesViewModelDependencies(movieService: movieService, rxReachabilitySerivce: rxReachabilitySerivce)
        viewModelUnderTest = TopRatedMoviesViewModel(with: topRatedMoviesViewModelDependencies)
    }
    
    override func tearDown() {
        viewModelUnderTest = nil
        super.tearDown()
    }
    
    func test_topRatedMovies_returnsValidObjects() {
        movieService.moviesReturnValue = .just([topRatedMovie])
        
        testScheduler.createHotObservable([.next(300, ())])
            .bind(to: viewModelUnderTest.reload)
            .disposed(by: disposeBag)
        
        testScheduler.createHotObservable([.next(400, (0))])
            .bind(to: viewModelUnderTest.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        let result = testScheduler.start { self.viewModelUnderTest.sortedMovies }
        XCTAssertEqual(result.events.count, 1)
        
        guard let movie = result.events.first?.value.element?.first else {
            return XCTFail()
        }
        
        XCTAssertEqual(movie.id, 1)
    }
    
    func test_topRatedMoviesWithNetworkError_emitsAlertMessage() {
        let error = NSError(domain: "TestDomain", code: 5, userInfo: nil)
        movieService.moviesReturnValue = .error(error)
        
        testScheduler.createHotObservable([.next(300, ())])
            .bind(to: viewModelUnderTest.reload)
            .disposed(by: disposeBag)
        
        viewModelUnderTest
            .sortedMovies
            .subscribe()
            .disposed(by: disposeBag)
        
        let result = testScheduler.start { self.viewModelUnderTest.alertMessage.map { $0.localizedDescription } }
        XCTAssertEqual(result.events, [next(300, error.localizedDescription)])
    }
    
    func test_searchButtonAction_emitsValidOutput() {
        let button = UIButton()
        button.rx.bind(to: viewModelUnderTest.searchButtonAction, input: "Test")
        var output: String!
        
        viewModelUnderTest
            .searchButtonAction
            .executionObservables
            .switchLatest()
            .subscribe(onNext: { (textOutput) in
                output = textOutput
            })
            .disposed(by: disposeBag)
        
        button.sendActions(for: .touchUpInside)
        XCTAssertEqual(output, "Test")
    }
    
    func test_topRatedMovies_emitsActivityIndicator() {
        movieService.moviesReturnValue = .just([topRatedMovie])
        
        testScheduler.createHotObservable([.next(300, ())])
            .bind(to: viewModelUnderTest.reload)
            .disposed(by: disposeBag)
        
        viewModelUnderTest
            .sortedMovies
            .subscribe()
            .disposed(by: disposeBag)
        
        //skip(1) since it's BehaviorSubject and observing initial value is undesirable
        let result = testScheduler.start { self.viewModelUnderTest.activityIndicator.asObservable().skip(1) }
        XCTAssertEqual(result.events, [.next(300, true), .next(300, false)])
    }
    
    func test_networkStatusChange_firesReloading() {
        movieService.moviesReturnValue = .just([topRatedMovie])

        testScheduler.createHotObservable([.next(400, (.unknown)), .next(410, (.offline)), .next(420, (.online)), .next(430, (.offline))])
            .bind(to: rxReachabilitySerivce.statusReturnValue)
            .disposed(by: disposeBag)
        
        testScheduler.createHotObservable([.next(300, (0))])
            .bind(to: viewModelUnderTest.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        let result = testScheduler.start { self.viewModelUnderTest.sortedMovies.map { _ in true } }
        XCTAssertEqual(result.events, [.next(300, (true)), .next(420, (true)), .next(430, (true))]) //400 and 410 are skipped as expected
    }
}

private struct TopRatedMoviesViewModelDependencies: HasMovieServiceProtocol, HasRxReachabilityServiceProtocol {
    let movieService: MovieServiceProtocol
    let rxReachabilitySerivce: RxReachabilitySerivceProtocol
}
