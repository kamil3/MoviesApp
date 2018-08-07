//
//  AppConfig.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

struct AppConfig {
    let baseURL: String
    let apiKey: String
    
    init(baseURL: String, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    init() {
        self.baseURL = "https://api.themoviedb.org/3/"
        self.apiKey = "cb85510e7263ae19d60df6a26050613f"
    }
}
