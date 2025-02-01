//
//  MovieRepository.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getNowPlayMovies() async throws -> [Movie]
    func getPopularMovies() async throws -> [Movie]
    func getUpComingMovies() async throws -> [Movie]
    func getMovieDetails(id: Int) async throws -> MovieDetails
}

struct MovieRepository: MovieRepositoryProtocol {
    
    private let networkService: HTTPClientProtocol
    private let moviesDataManager: DataControllerProtocol
    private let reachabilityManager: ReachabilityManagerProtocol
    init(networkService: HTTPClientProtocol, moviesDataManager: DataControllerProtocol, reachabilityManager: ReachabilityManagerProtocol) {
        self.networkService = networkService
        self.reachabilityManager = reachabilityManager
        self.moviesDataManager = moviesDataManager
    }
    
    func getPopularMovies() async throws -> [Movie] {
        guard reachabilityManager.isConnectedToNetwork() else {
            return moviesDataManager.fetchMovies(category: .popular)
        }
        let request = MoviesReq.FetchPopularMovies()
        let response: PopularMoviesResponse = try await networkService.fetch(request: request)
        let movies = analyseMovies(response)
        moviesDataManager.saveMovies(movies, category: .popular)
        return movies
    }
    
    func getUpComingMovies() async throws -> [Movie] {
        guard reachabilityManager.isConnectedToNetwork() else {
            return moviesDataManager.fetchMovies(category: .upcoming)
        }
        let request = MoviesReq.FetchUpComingMovies()
        let response: PopularMoviesResponse = try await networkService.fetch(request: request)
        let movies = analyseMovies(response)
        moviesDataManager.saveMovies(movies, category: .upcoming)
        return movies
    }
    
    func getNowPlayMovies() async throws -> [Movie] {
        guard reachabilityManager.isConnectedToNetwork() else {
            return moviesDataManager.fetchMovies(category: .nowPlaying)
        }
        let request = MoviesReq.FetchNowPlayingMovies()
        let response: PopularMoviesResponse = try await networkService.fetch(request: request)
        let movies = analyseMovies(response)
        moviesDataManager.saveMovies(movies, category: .nowPlaying)
        return movies
    }
    
    func getMovieDetails(id: Int) async throws -> MovieDetails {
        let request = MoviesReq.FetchMovieDetails(movieId: id)
        let response: MoviesDetailsResponse = try await networkService.fetch(request: request)
        return MovieDetails(from: response)
    }
    
    private func analyseMovies(_ response: PopularMoviesResponse) -> [Movie] {
        return response.results?.compactMap{ Movie(from: $0)} ?? []
    }
}
