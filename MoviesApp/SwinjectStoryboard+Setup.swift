//
//  SwinjectStoryboard+Setup.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import Alamofire

extension SwinjectStoryboard {
    @objc class func setup() {
        Container.loggingFunction = nil
        
        //APP DEPENDENCIES CONTAINER
        defaultContainer.register(AppDependency.self) { r in
            return AppDependency(movieService: r.resolve(MovieServiceProtocol.self)!)
        }
        
        //CORE COMPONENTS
        
        /* AppConfig */
        defaultContainer.register(AppConfig.self) { r in
            return AppConfig()
        }
        .inObjectScope(.container)
        
        /* ApiClient */
        defaultContainer.register(ApiClientProtocol.self) { r in
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 20
            let sessionManager = SessionManager(configuration: configuration)
            return ApiClient(sessionManager: sessionManager)
        }
        .inObjectScope(.container)
        
        /* MovieService */
        defaultContainer.register(MovieServiceProtocol.self) { r in
            return MovieService(with: r.resolve(ApiClientProtocol.self)!)
        }
        .inObjectScope(.container)
    }
}
