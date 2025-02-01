//
//  ConfigurationsResponse.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

struct ConfigurationsResponse: Codable {
    let images: ImagesConfigurationsResponse
}

struct ImagesConfigurationsResponse: Codable {
    let secureBaseURL: String
    let posterSizes: [String]

    enum CodingKeys: String, CodingKey {
        case secureBaseURL = "secure_base_url"
        case posterSizes = "poster_sizes"

    }
}
