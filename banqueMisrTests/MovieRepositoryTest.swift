//
//  MovieRepositoryTest.swift
//  banqueMisr
//
//  Created by Hady Helal on 01/02/2025.
//

import XCTest

@testable import banqueMisr

final class MovieRepositoryTest: XCTestCase {
    
    var sut: MovieRepository!
    var moviesDataManagerMock: DataControllerProtocol!
    
    override func setUp() {
        let networkService  = MockNetworkService()
        let mockRachability = MockReachability(mockConnected: false)
        
        moviesDataManagerMock = DataController.shared
        
        sut = MovieRepository(networkService: networkService,
                              moviesDataManager: moviesDataManagerMock,
                              reachabilityManager: mockRachability)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testPopularMoviesLocalFetch() async {
        let movies = [
            Movie(id: 1, image: "imageA", title: "movie A", releaseDate: "12-12-2012"),
            Movie(id: 2, image: "imageB", title: "movie B", releaseDate: "30-12-2012")
        ]
        
        moviesDataManagerMock.saveMovies(movies, category: .popular)
        
        let popularMovies = try? await sut.getPopularMovies()
        
        XCTAssertNotNil(popularMovies)
        XCTAssertEqual(movies, popularMovies)
    }
    
}

struct MockNetworkService: HTTPClientProtocol {
    var shouldFail = false
    
    func fetch<T: Codable>(request: APIRequest) async throws -> T {
        if shouldFail {
            throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        }
        
        if request is MoviesReq.FetchPopularMovies {
            let response = PopularMoviesResponse(results: [MovieResult(id: 1,
                                                                       posterPath: "Movie 1"
                                                                       , releaseDate: "/image1.jpg",
                                                                       title: "2024-01-01")])
            return response as! T
        }
                
        throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unknown request"])
    }
}

struct MockReachability: ReachabilityManagerProtocol {
    
    let mockConnected: Bool
    
    func isConnectedToNetwork() -> Bool {
        return mockConnected
    }
}


final class MockDataController: DataControllerProtocol {
    
    var popularTempMovies    = [Movie]()
    var nowPlayingTempMovies = [Movie]()
    var upComingTempMovies   = [Movie]()
    
    func saveMovies(_ movies: [Movie], category: MovieCategory) {
        switch category {
        case .nowPlaying:
            nowPlayingTempMovies = movies
        case .popular:
            popularTempMovies = movies
        case .upcoming:
            upComingTempMovies = movies
        }
    }
    
    func fetchMovies(category: MovieCategory) -> [Movie] {
        switch category {
        case .nowPlaying:
            nowPlayingTempMovies
        case .popular:
            popularTempMovies
        case .upcoming:
            upComingTempMovies
        }
    }
    
    func deleteMovies(category: MovieCategory) {
        switch category {
        case .nowPlaying:
            nowPlayingTempMovies = []
        case .popular:
            popularTempMovies = []
        case .upcoming:
            upComingTempMovies = []
        }
    }
    
}
