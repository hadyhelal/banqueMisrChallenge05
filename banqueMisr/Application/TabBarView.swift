//
//  TabBarView.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @StateObject private var imageCacheManager = ImageCacheManager()

    var body: some View {

        ZStack {
            
            Color.black
            TabView(selection: $selectedTab) {
                MovieListView(viewModel: MoviesListViewModel(moviesUseCase: NowPlayingMoviesUseCase(repository: MovieRepository(networkService: NetworkService(),
                                                                                                                                moviesDataManager: DataController.shared,
                                                                                                                                reachabilityManager: ReachabilityManager())) ), viewTitle: "Now Playing")
                    .tabItem { Label("Now Playing", systemImage: "film") }
                    .tag(0)
                
                MovieListView(viewModel: MoviesListViewModel(moviesUseCase: PopularMoviesUseCase(repository: MovieRepository(networkService: NetworkService(),
                                                                                                                             moviesDataManager: DataController.shared,
                                                                                                                             reachabilityManager: ReachabilityManager()))), viewTitle: "Popular")
                    .tabItem { Label("Popular", systemImage: "star") }
                    .tag(1)
                
                MovieListView(viewModel: MoviesListViewModel(moviesUseCase: UpComingMoviesUseCase(repository: MovieRepository(networkService: NetworkService(),
                                                                                                                              moviesDataManager: DataController.shared,
                                                                                                                              reachabilityManager: ReachabilityManager()))), viewTitle: "Upcoming")
                    .tabItem { Label("Upcoming", systemImage: "calendar") }
                    .tag(2)
            }
            .tint(Color.red)
            .background(Color.clear)
            .environmentObject(imageCacheManager)
        }
    }
}
