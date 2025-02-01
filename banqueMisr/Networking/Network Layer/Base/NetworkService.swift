//
//  NetworkService.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

protocol HTTPClientProtocol {
    func fetch<T: Codable>(request: APIRequest) async throws -> T
}

struct NetworkService: HTTPClientProtocol {
    
    // MARK: - Properties
    
    private let responseAnalyser: ResponseAnalyserProtocol
    init(responseAnalyser: ResponseAnalyserProtocol = ResponseAnalyser()) {
        self.responseAnalyser = responseAnalyser
    }
    
    // MARK: - Fetch Data
    
    func fetch<T: Codable>(request: APIRequest) async throws -> T {
        let urlRequest = try createURLRequest(from: request)
        NetworkLogger.log(request: urlRequest)
        return try await performRequest(urlRequest)
    }
    
    // MARK: - Perform Request
    
    private func performRequest<T: Codable>(_ urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        NetworkLogger.log(data: data, response: response as? HTTPURLResponse)
        
        if let statusError = responseAnalyser.analyse(response: response as? HTTPURLResponse, and: data) {
            throw statusError
        }
        
        guard let responseObj = data.convertTo(model: T.self) else {
            throw NetworkError.decode
        }
        
        return responseObj
    }
    
    // MARK: - Create URLRequest
    
    private func createURLRequest(from request: APIRequest) throws -> URLRequest {
        let urlString = request.baseURL + (request.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ((request.body == nil ? request.query : request.body) ?? [:])
        
        switch request.encoding {
        case .url:
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            urlRequest.url = components.url
        case .json:
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        return urlRequest
    }
}

