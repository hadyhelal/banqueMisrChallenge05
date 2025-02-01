//
//  MoviesListViewModel.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

class MoviesListViewModel: BaseViewModel {
    
    @Published var movies: [Movie] = []
    @Published var isShimmering = false
    
    private let moviesUseCase: MoviesUseCaseProtocol
    
    private var isDataFetched = false
    
    init(moviesUseCase: MoviesUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
    }
    
    @MainActor
    func fetchMovies() async {
        guard isDataFetched == false else { return }
        isDataFetched = true // prevent repeated calling for api for now to prevent refreshing...
        do {
            movies = .tempMovies
            isShimmering = true
            defer { isShimmering = false }
            movies = try await moviesUseCase.executeFetchingMovies()
        } catch {
            handleError(error)
            movies = []
        }
    }
}
