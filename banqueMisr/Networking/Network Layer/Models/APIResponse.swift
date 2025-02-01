//
//  APIResponse.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

enum APIResponse<T: Codable> {
    case success(T)
    case failure(ErrorResponse)
}

struct ErrorResponse: Codable {
    var success: Bool?
    var statusCode: Int?
    var statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
