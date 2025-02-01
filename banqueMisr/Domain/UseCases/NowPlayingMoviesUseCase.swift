//
//  NowPlayingMoviesUseCase.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

struct NowPlayingMoviesUseCase: MoviesUseCaseProtocol {
    
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func executeFetchingMovies() async throws -> [Movie] {
        return try await repository.getNowPlayMovies()
    }
}

protocol MoviesUseCaseProtocol {
    func executeFetchingMovies() async throws -> [Movie]
}


