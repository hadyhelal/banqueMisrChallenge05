//
//  SplashConifgurationsUseCase.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

protocol SplashConifgurationsUseCaseProtocol {
    func executeFetchConfigurationss() async throws
}

struct SplashConifgurationsUseCase: SplashConifgurationsUseCaseProtocol {

    private let repository: ConifgurationsRepositoryProtocol
    
    init(repository: ConifgurationsRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeFetchConfigurationss() async throws {
        try await repository.fetchConfigurations()
    }
}
