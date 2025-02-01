//
//  Configurations.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

struct Configurations {
    let imagesURL: String
}

extension Configurations {
    init(from model: ConfigurationsResponse?) {
        let baseImage = model?.images.secureBaseURL ?? ""
        
        let sizes = model?.images.posterSizes ?? []
        let lastIndex = sizes.count - 1

        var imageSize: String
        
        if lastIndex >= 1 {
            imageSize = sizes[lastIndex - 1]
        } else {
            imageSize = "original"
        }
        
        self.imagesURL = "\(baseImage)\(imageSize)"
    }
}

