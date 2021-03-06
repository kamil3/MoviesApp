//
//  RxReachabilityServiceMock.swift
//  MoviesAppTests
//
//  Created by Kamil Waszkiewicz on 27.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import RxSwift
@testable import MoviesApp

class RxReachabilityServiceMock: RxReachabilitySerivceProtocol {
    var statusReturnValue = PublishSubject<Reachability>()
    
    var status: Observable<Reachability> {
        return statusReturnValue.asObservable()
    }
    
    func startMonitor(_ host: String) -> Bool {
        return true
    }
    
    func stopMonitor() {}
}
