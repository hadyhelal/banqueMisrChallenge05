//
//  APIRequest.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

protocol APIRequest {
    var path: String { get }
    var baseURL: String { get }
    var method: RequestMethod { get }
    var encoding: RequestEncoding { get }
    var token: String? { get }
    var headers: [String: String]? { get }
    var query: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension APIRequest {
    
    var baseURL: String { Helper.baseURL }
    var method: RequestMethod { .get }
    var encoding: RequestEncoding { method == .get ? .url : .json }
    var query: [String: Any]? { nil }
    var body: [String: Any]? { nil }
    var token: String? { Helper.token }
    
    var headers: [String: String]? {
        return [
            "Authorization": "Bearer \(token ?? "")",
            "Accept": "application/json",
        ]
    }
}
