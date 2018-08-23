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
            return AppDependency(movieService: r.resolve(MovieServiceProtocol.self)!, rxReachabilitySerivce: r.resolve(RxReachabilitySerivceProtocol.self)!)
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
        
        /* MovieService */
        defaultContainer.register(MovieServiceProtocol.self) { r in
            return MovieService(with: r.resolve(ApiClientProtocol.self)!)
        }
        
        /* RxReachabilityService */
        defaultContainer.register(RxReachabilitySerivceProtocol.self) { r in
            return RxReachabilitySerivce()
        }
        
        //VIEW CONTROLLERS + VIEW MODELS
        
        /* TopRatedMovies */
        defaultContainer.storyboardInitCompleted(TopRatedMoviesViewController.self) { r, c in
            c.viewModel = r.resolve(TopRatedMoviesViewModel.self)
        }
        
        defaultContainer.register(TopRatedMoviesViewModel.self) { r in
            return TopRatedMoviesViewModel(with: r.resolve(AppDependency.self)!)
        }
        
        /* PopularMovies */
        defaultContainer.storyboardInitCompleted(PopularMoviesViewController.self) { r, c in
            c.viewModel = r.resolve(PopularMoviesViewModel.self)
        }
        
        defaultContainer.register(PopularMoviesViewModel.self) { r in
            return PopularMoviesViewModel(with: r.resolve(AppDependency.self)!)
        }
        
        /* AlternativeTitles */
        defaultContainer.storyboardInitCompleted(AlternativeTitlesViewController.self) { r, c in
            c.viewModel = r.resolve(AlternativeTitlesViewModel.self)
        }
        
        defaultContainer.register(AlternativeTitlesViewModel.self) { r in
            return AlternativeTitlesViewModel()
        }
    }
}
