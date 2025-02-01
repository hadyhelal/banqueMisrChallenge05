//
//  MovieDetailsViewModel.swift
//  banqueMisr
//
//  Created by Hady Helal on 02/02/2025.
//

import Foundation

final class MovieDetailsViewModel: BaseViewModel {
    @Published var isShimmering = false
    
    @Published var movieDetails = MovieDetails.mockData
    
    let movieId: Int
    let useCase: MovieDetailsUseCaseProtocol
    init(movieId: Int, useCase: MovieDetailsUseCaseProtocol) {
        self.movieId = movieId
        self.useCase = useCase
    }
    
    @MainActor func getMovie() async {
        isShimmering = true
        defer { isShimmering = false }
        do {
            movieDetails = try await useCase.executeFetchingMovieDetails(id: movieId)
        } catch {
            handleError(error)
        }
    }
}
