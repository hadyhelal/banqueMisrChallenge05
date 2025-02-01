//
//  ResponseAnalyser.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

protocol ResponseAnalyserProtocol {
    func analyse(response: HTTPURLResponse?, and data: Data?) -> Error?
}

struct ResponseAnalyser: ResponseAnalyserProtocol {
    
    func analyse(response: HTTPURLResponse?, and data: Data?) -> Error? {
        
        guard let data = data else {
            return NetworkError.other(msg: "No Data Found")
        }
        
        if let errorResponse = data.convertTo(model: ErrorResponse.self), let errorMessage = errorResponse.statusMessage {
            return NetworkError.other(msg: errorMessage)
        }
        
        guard let httpResponse = response else {
            return NetworkError.other(msg: "Invalid Response")
        }
        
        if let statusError = analyse(statusCode: httpResponse.statusCode, from: data) {
            return statusError
        }

        return nil
    }
    
    private func analyse(statusCode: Int, from data: Data) -> Error? {
        
        if !((200...299).contains(statusCode)) {
            switch statusCode {
            case 404:
                return NetworkError.notExist
            default:
                return NetworkError.other(msg: "Something went wrong")
            }
        }
        
        return nil
    }
    
}
