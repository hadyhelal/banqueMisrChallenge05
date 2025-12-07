//
//  MovieListView.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject var viewModel: MoviesListViewModel
    
    let viewTitle: String
    
    private let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 16), count: Helper.isIpad ? 3 : 2)
        
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: gridColumns, spacing: Helper.isIpad ? 16 : 12) {
                    moviesListGrid
                }
            }
            .padding(.horizontal)
            .navigationTitle(viewTitle)
            .task {
                await viewModel.fetchMovies()
            }
//            .errorMessage(errorMessage: $viewModel.errorMessage)
        }
    }
    
    private var moviesListGrid: some View {
        ForEach(viewModel.movies) { movie in
            NavigationLink(destination: movieDetail(id: movie.id) ) {
                MovieCardView(movie: movie)
//                    .shimmeringRedact(shouldRedact: viewModel.isShimmering)
            }
        }
    }
    
    private func movieDetail(id: Int) -> some View {
        MovieDetailsView(
            viewModel: MovieDetailsViewModel(
                movieId: id,
                useCase: MovieDetailsUseCase(repository: MovieRepository(networkService: NetworkService(),
                                                                         moviesDataManager: DataController.shared,
                                                                         reachabilityManager: ReachabilityManager()))
            )
        )
    }
    
}
