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
import SwinjectStoryboard

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
        var imageDataDictionary: [Int: Data?] = [:]
        let dispatchGroup = DispatchGroup()
        let imageURLString = SwinjectStoryboard.defaultContainer.resolve(AppConfig.self)!.imagesURL
        let _ = DispatchQueue.global(qos: .background)
        DispatchQueue.concurrentPerform(iterations: movies.count) { index in
            guard let imageUrl = URL(string: "\(imageURLString)\(ImageSizeConstants.TopRatedSize)/\(movies[index].posterPath!)") else { return }
            dispatchGroup.enter()
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                imageDataDictionary[index] = data
                dispatchGroup.leave()
            })
                .resume()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.persistenceManager.persistentContainer.performBackgroundTask { context in
                var movieEntities = [MovieEntity]()
                for (index, movie) in movies.enumerated() {
                    guard let id = movie.id else { return }
                    var movieEntity: MovieEntity!
                    if let entity = self.loadMovie(withId: id, context: context) {
                        movieEntity = self.movieTranslationLayer.convert(movie: movie, movieEntity: entity, context: context)
                    } else {
                        movieEntity = self.movieTranslationLayer.convert(movie: movie, movieEntity: nil, context: context)
                    }
                    movieEntity.imageData = imageDataDictionary[index] ?? nil
                    movieEntities.append(movieEntity)
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
