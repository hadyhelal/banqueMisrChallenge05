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
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(
                            destination: MovieDetailsView(
                                viewModel: MovieDetailsViewModel(
                                    movieId: movie.id,
                                    useCase: MovieDetailsUseCase(repository: MovieRepository(networkService: NetworkService(),
                                                                                             moviesDataManager: DataController.shared,
                                                                                             reachabilityManager: ReachabilityManager()))
                                )
                            )
                        ) {
                            MovieCardView(movie: movie)
                                .shimmeringRedact(shouldRedact: viewModel.isShimmering)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle(viewTitle)
            .task {
                await viewModel.fetchMovies()
            }
            .errorMessage(errorMessage: $viewModel.errorMessage)
        }
    }
    
}
