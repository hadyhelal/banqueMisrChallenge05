//
//  MovieDetailsUseCase.swift
//  banqueMisr
//
//  Created by Hady Helal on 02/02/2025.
//

import Foundation

struct MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func executeFetchingMovieDetails(id: Int) async throws -> MovieDetails {
        return try await repository.getMovieDetails(id: id)
    }
}

protocol MovieDetailsUseCaseProtocol {
    func executeFetchingMovieDetails(id: Int) async throws -> MovieDetails
}
