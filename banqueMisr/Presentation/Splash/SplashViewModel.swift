//
//  SplashViewModel.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

final class SplashViewModel: BaseViewModel {
        
    private(set) var finishFetchingConfigurations = false
    
    let useCase: SplashConifgurationsUseCaseProtocol
    init(useCase: SplashConifgurationsUseCaseProtocol) {
        self.useCase = useCase
    }
    
    @MainActor func getConfigurations() async {
        do {
            isLoading = true
            defer { isLoading = false }
            try await useCase.executeFetchConfigurationss()
            finishFetchingConfigurations = true
        } catch {
            handleError(error)
        }
    }
}


