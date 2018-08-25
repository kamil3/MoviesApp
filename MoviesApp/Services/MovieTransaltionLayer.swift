//
//  MovieTranslation.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 24.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import CoreData

protocol MovieTranslationLayerProtocol {
    func convert(movie: Movie, movieEntity: MovieEntity?, context: NSManagedObjectContext) -> MovieEntity
    func convert(entity: MovieEntity) -> Movie
}

struct MovieTranslationLayer: MovieTranslationLayerProtocol {
    // MARK:- MovieTransaltionLayerProtocol
    func convert(movie: Movie, movieEntity: MovieEntity? = nil, context: NSManagedObjectContext) -> MovieEntity {
        let entity = movieEntity ?? MovieEntity(context: context)
        entity.title = movie.title
        entity.posterPath = movie.posterPath
        entity.voteAverage = movie.voteAverage ?? 0.0
        
        if let id = movie.id {
            entity.id = Int64(id)
        }
        
        if let voteCount = movie.voteCount {
            entity.voteCount = Int64(voteCount)
        }
        
        if let type = movie.type?.rawValue {
            entity.type = Int64(type)
        }
        
        return entity
    }
    
    func convert(entity: MovieEntity) -> Movie {
        let movie = Movie.create(id: Int(entity.id),
                                 title: entity.title,
                                 voteCount: Int(entity.voteCount),
                                 voteAverage: entity.voteAverage,
                                 posterPath: entity.posterPath,
                                 imageData: entity.imageData)
        return movie
    }
}
