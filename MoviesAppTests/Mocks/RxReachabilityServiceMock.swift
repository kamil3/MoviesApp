//
//  RxReachabilityServiceMock.swift
//  MoviesAppTests
//
//  Created by Kamil Waszkiewicz on 27.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import RxSwift
@testable import MoviesApp

struct RxReachabilityServiceMock: RxReachabilitySerivceProtocol {
    var statusReturnValue: Observable<Reachability> = .empty()
    
    var status: Observable<Reachability> {
        return statusReturnValue
    }
    
    func startMonitor(_ host: String) -> Bool {
        return true
    }
    
    func stopMonitor() {}
}
