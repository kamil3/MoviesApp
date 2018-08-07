//
//  ApiClient.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import Alamofire
import ObjectMapper
import RxSwift
import SwiftyBeaver


protocol ApiClientProtocol {
    func convenientRequest<T: Mappable>(for requestRoute: RequestRouter) -> Observable<[T]>
    func convenientRequest<T: Mappable>(for requestRoute: RequestRouter) -> Observable<T>
    func convenientRequest(for requestRoute: RequestRouter) -> Observable<Data>
    func convenientRequest(for requestRoute: RequestRouter) -> Observable<[String: Any]>
}

struct ApiClient: ApiClientProtocol {
    let sessionManager: SessionManager
    let mappingDataObject: MappingDataObjectProtocol
    
    init(sessionManager: SessionManager, mappingDataObject: MappingDataObjectProtocol = MappingDataObject()) {
        self.sessionManager = sessionManager
        self.mappingDataObject = mappingDataObject
    }
    
    // MARK:- ApiClientProtocol
    func convenientRequest<T: Mappable>(for requestRoute: RequestRouter) -> Observable<[T]> {
        return data(for: requestRoute).map { data in
            guard let objects: [T] = self.mappingDataObject.map(withData: data) else {
                throw RequestError.IncorrectModelMapping
            }
            return objects
        }
    }
    
    func convenientRequest<T: Mappable>(for requestRoute: RequestRouter) -> Observable<T> {
        return convenientRequest(for: requestRoute).map { $0[0] }
    }
    
    func convenientRequest(for requestRoute: RequestRouter) -> Observable<Data> {
        return data(for: requestRoute)
    }
    
    func convenientRequest(for requestRoute: RequestRouter) -> Observable<[String: Any]> {
        return data(for: requestRoute).map { data in
            guard let JSONObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments), let dict = JSONObject as? [String: Any] else {
                throw RequestError.IncorrectModelMapping
            }
            return dict
        }
    }
    
    // MARK:- Private
    private func data(for requestRoute: RequestRouter) -> Observable<Data> {
        let request = sessionManager.request(requestRoute).validate()
        return Observable.create({ observable in
            request.responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        observable.onError(RequestError.IncorrectDataReturned)
                        return
                    }
                    observable.onNext(data)
                    observable.onCompleted()
                case .failure(let error):
                    var requestError: RequestError!
                    if let err = error as? AFError {
                        guard let statusCode = response.response?.statusCode else {
                            observable.onError(RequestError.IncorrectDataReturned)
                            return
                        }
                        requestError = RequestError.init(code: statusCode, description: err.localizedDescription)
                    } else {
                        let e = error as NSError
                        requestError = RequestError.init(code: e.code, description: e.localizedDescription)
                    }
                    observable.onError(requestError)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        })
        //retry if needed
        .catchError({ (error: Swift.Error) -> Observable<Data> in
            let requestError = error as! RequestError
            SwiftyBeaver.error("Error: \(requestError.localizedDescription)")
            // Here we can do additional tasks with requestError, i.e. post notification depending on status code / error's type
            return Observable.error(requestError)
        })
    }
}
