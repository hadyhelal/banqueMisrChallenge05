//
//  MovizApp.swift
//  MovizApp
//
//  Created by Hady Helal on 31/01/2025.
//

import SwiftUI

@main
struct MovizApp: App {
    
    @StateObject private var appRootManager = RootViewManager()

    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .splash:
                    SplashView(
                        viewModel: SplashViewModel(useCase: SplashConifgurationsUseCase(
                        repository: ConfigurationsRepository(networkService: NetworkService(),
                                                             reachabilityManager: ReachabilityManager()))))
                case .home:
                    TabBarView()
                }
            }
            .environmentObject(appRootManager)
            
        }
    }
}

final class RootViewManager: ObservableObject {
    
    @Published var currentRoot: AppRoots = .splash
    
    enum AppRoots {
        case splash
        case home
    }
}
