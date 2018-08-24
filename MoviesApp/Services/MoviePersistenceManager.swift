//
//  MoviePersistenceManager.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 24.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

protocol MoviePersistenceManagerProtocol {
    
}

struct MoviePersistenceManager: MoviePersistenceManagerProtocol {
    private let persistenceManager: PersistenceManagerProtocol
    
    init(with persistenceManager: PersistenceManagerProtocol) {
        self.persistenceManager = persistenceManager
    }
}
