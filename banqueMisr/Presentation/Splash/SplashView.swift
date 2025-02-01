//
//  SplashView.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import SwiftUI

struct SplashView: View {
    
    @StateObject var viewModel: SplashViewModel
    @EnvironmentObject var appRootManager: RootViewManager
    
    var body: some View {
        
        ZStack {
            
            Color.black
            
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .scaleEffect(1.5)
            }
        }
        .task {
            await viewModel.getConfigurations()
        }
        .onChange(of: viewModel.finishFetchingConfigurations) { _, newValue in
            if newValue {
                appRootManager.currentRoot = .home
            }
        }
        .errorMessage(errorMessage: $viewModel.errorMessage)
        
    }
    
}
