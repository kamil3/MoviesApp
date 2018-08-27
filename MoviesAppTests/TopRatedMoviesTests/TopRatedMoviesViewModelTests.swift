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

    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}


