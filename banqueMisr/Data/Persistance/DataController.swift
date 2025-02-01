//
//  DataController.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import CoreData
import Foundation

protocol DataControllerProtocol {
    func saveMovies(_ movies: [Movie], category: MovieCategory)
    func fetchMovies(category: MovieCategory) -> [Movie]
    func deleteMovies(category: MovieCategory)
    
}

final class DataController: ObservableObject, DataControllerProtocol {
    
    private let persistentContainer: NSPersistentContainer

    static let shared = DataController()
    
    private let storeQueue = DispatchQueue(label: "coreData.queue", attributes: .concurrent)
    
    init(persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "MoviesModel")) {
        self.persistentContainer = persistentContainer
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Save Movies
    func saveMovies(_ movies: [Movie], category: MovieCategory) {
        storeQueue.sync { [weak self] in
            guard let self else { return }
            let context = viewContext
            
            deleteMovies(category: category)
            
            for movie in movies {
                let cdMovie = CDMovie(context: context)
                cdMovie.id = Int32(movie.id)
                cdMovie.image = movie.image
                cdMovie.title = movie.title
                cdMovie.releaseDate = movie.releaseDate
                cdMovie.category = category.rawValue
            }
            
            saveContext()
        }
    }

    func fetchMovies(category: MovieCategory) -> [Movie] {
        storeQueue.sync {
            let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
            request.predicate = NSPredicate(format: "category == %@", category.rawValue)
            do {
                let results = try viewContext.fetch(request)
                return results.compactMap { Movie(from: $0)}
            } catch {
                return []
            }
        }
    }

    func deleteMovies(category: MovieCategory) {
        storeQueue.sync { [weak self] in
            guard let self else { return }
            let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
            request.predicate = NSPredicate(format: "category == %@", category.rawValue)
            
            do {
                let moviesToDelete = try viewContext.fetch(request)
                for movie in moviesToDelete {
                    viewContext.delete(movie)
                }
                saveContext()
            } catch {
                print("Failed to delete movies: \(error)")
            }
        }
    }

    // MARK: - Core Data Saving Support
    private func saveContext() {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    

    
}

enum MovieCategory: String {
    case nowPlaying = "nowPlaying"
    case popular = "popular"
    case upcoming = "upcoming"
}
