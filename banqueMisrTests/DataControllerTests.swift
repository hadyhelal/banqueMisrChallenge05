//
//  DataControllerTests.swift
//  banqueMisrTests
//
//  Created by Hady Helal on 31/01/2025.
//

import XCTest
import CoreData
@testable import banqueMisr

class DataControllerTests: XCTestCase {

    var dataController: DataController!
    var persistentContainer: NSPersistentContainer!

    override func setUp() {
        super.setUp()

        persistentContainer = NSPersistentContainer(name: "MoviesModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]

        dataController = DataController(persistentContainer: persistentContainer)
    }

    override func tearDown() {
        dataController = nil
        persistentContainer = nil
        super.tearDown()
    }
    
    func testSaveMovies() {
        let movies = [
            Movie(id: 1, image: "image1", title: "Movie 1", releaseDate: "2023-01-01"),
            Movie(id: 2, image: "image2", title: "Movie 2", releaseDate: "2023-02-01")
        ]

        dataController.saveMovies(movies, category: .nowPlaying)

        let fetchedMovies = dataController.fetchMovies(category: .nowPlaying)
        XCTAssertEqual(fetchedMovies.count, 2)
    }
    
    func testFetchMovies() {
        let movies = [
            Movie(id: 1, image: "image1", title: "Movie 1", releaseDate: "2023-01-01"),
            Movie(id: 2, image: "image2", title: "Movie 2", releaseDate: "2023-02-01")
        ]
        dataController.saveMovies(movies, category: .popular)
        
        let fetchedMovies = dataController.fetchMovies(category: .popular)

        XCTAssertEqual(fetchedMovies.count, 2)
        XCTAssertEqual(fetchedMovies.first(where: {$0.id == 1})?.title, "Movie 1")
        XCTAssertEqual(fetchedMovies.first(where: {$0.id == 2})?.title, "Movie 2")
    }
    
    func testDeleteMovies() {
        let movies = [
            Movie(id: 1, image: "image1", title: "Movie 1", releaseDate: "2023-01-01"),
            Movie(id: 2, image: "image2", title: "Movie 2", releaseDate: "2023-02-01")
        ]
        
        dataController.saveMovies(movies, category: .popular)
        
        let fetchedMovies = dataController.fetchMovies(category: .popular)
        
        XCTAssertEqual(fetchedMovies.count, 2)
        
        dataController.deleteMovies(category: .popular)
        
        let moviesAfterDeletion = dataController.fetchMovies(category: .popular)
        
        XCTAssertEqual(moviesAfterDeletion.count, 0)
    }
    
    func testSavePopularCategory() {
        let movies = [
            Movie(id: 1, image: "image1", title: "Movie 1", releaseDate: "2023-01-01"),
            Movie(id: 2, image: "image2", title: "Movie 2", releaseDate: "2023-02-01")
        ]
        dataController.saveMovies(movies, category: .popular)

        // Act
        let fetchedMovies = dataController.fetchMovies(category: .popular)

        // Assert
        XCTAssertEqual(fetchedMovies.count, 2)
        XCTAssertEqual(fetchedMovies.first(where: {$0.id == 1})?.title, "Movie 1")
        XCTAssertEqual(fetchedMovies.first(where: {$0.id == 2})?.title, "Movie 2")
    }
    
    func testNowPlayCategory() {
        let movies = [
            Movie(id: 1, image: "image1", title: "Movie 1", releaseDate: "2023-01-01"),
            Movie(id: 2, image: "image2", title: "Movie 2", releaseDate: "2023-02-01")
        ]
        dataController.saveMovies(movies, category: .nowPlaying)

        // Act
        let fetchedMovies = dataController.fetchMovies(category: .nowPlaying)

        // Assert
        XCTAssertEqual(fetchedMovies.count, 2)
        XCTAssertEqual(fetchedMovies.first(where: {$0.id == 1})?.title, "Movie 1")
        XCTAssertEqual(fetchedMovies.first(where: {$0.id == 2})?.title, "Movie 2")
    }
    
}
