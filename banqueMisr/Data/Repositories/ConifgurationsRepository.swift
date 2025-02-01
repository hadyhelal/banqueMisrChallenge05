//
//  ConifgurationsRepository.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

protocol ConifgurationsRepositoryProtocol {
    func fetchConfigurations() async throws
}

struct ConfigurationsRepository: ConifgurationsRepositoryProtocol {
    
    let networkService: HTTPClientProtocol
    let reachabilityManager: ReachabilityManagerProtocol
    init(networkService: HTTPClientProtocol, reachabilityManager: ReachabilityManagerProtocol) {
        self.networkService = networkService
        self.reachabilityManager = reachabilityManager
    }
    
    func fetchConfigurations() async throws {
        if reachabilityManager.isConnectedToNetwork() == false, Helper.imagesURL.isEmpty == false  {
            Helper.imagesURL = KeyValueCacher.getImageLink() ?? ""
        }
        
        let request = ConifgurationsReq.FetchConfigurations()
        let response: ConfigurationsResponse = try await networkService.fetch(request: request)
        let configuration = Configurations(from: response)
        Helper.imagesURL = configuration.imagesURL
        KeyValueCacher.saveImageLink(link: configuration.imagesURL)
        print("imageURL: \(Helper.imagesURL)")
    }
}
