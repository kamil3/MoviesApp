//
//  MoviePersistenceManager.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 24.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

protocol MoviePersistenceManagerProtocol {
    func saveMoviesToDatabase(movies: [Movie])
    func loadAllMovies(withType type: MovieType) -> Observable<[MovieEntity]>
}

struct MoviePersistenceManager: MoviePersistenceManagerProtocol {
    private let persistenceManager: PersistenceManagerProtocol
    private let movieTranslationLayer: MovieTranslationLayerProtocol
    
    init(with persistenceManager: PersistenceManagerProtocol, movieTranslationLayer: MovieTranslationLayerProtocol) {
        self.persistenceManager = persistenceManager
        self.movieTranslationLayer = movieTranslationLayer
    }
    
    // MARK:- MoviePersistenceManagerProtocol
    func saveMoviesToDatabase(movies: [Movie]) {
        for movie in movies {
            self.persistenceManager.persistentContainer.performBackgroundTask { context in
                var movieEntity: MovieEntity?
                guard let id = movie.id else { return }
                if let entity = self.loadMovie(withId: id, context: context) {
                    movieEntity = self.movieTranslationLayer.convert(movie: movie, movieEntity: entity, context: context)
                } else {
                    movieEntity = self.movieTranslationLayer.convert(movie: movie, movieEntity: nil, context: context)
                }
                do {
                    try context.save()
                } catch (let error) {
                    print(error)
                }
            }
        }
    }
    
    func loadAllMovies(withType type: MovieType) -> Observable<[MovieEntity]> {
        return Observable.create({ observer in
            let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "type == %d", type.rawValue)
            do {
                let movieEntities = try self.persistenceManager.persistentContainer.viewContext.fetch(fetchRequest)
                observer.onNext(movieEntities)
                observer.onCompleted()
            } catch (let error) {
                observer.onError(error)
            }
            
            return Disposables.create()
        })
    }
    
    private func loadMovie(withId id: Int, context: NSManagedObjectContext) -> MovieEntity? {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            return try context.fetch(fetchRequest).first
        }
        catch {
            print("error executing fetch request: \(error)")
            return nil
        }
    }
}
