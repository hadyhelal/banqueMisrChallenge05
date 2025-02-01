//
//  NetworkError.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//


import Foundation

enum NetworkError: Error, Equatable {
    case notExist
    case decode
    case invalidURL
    case other(msg: String)

    var errorMessage: String {
        switch self {
        case .other(let msg):
            return msg
        case .notExist:
            return "No Data Found"
        case .decode:
            return "Error in receiving data, please try again later!"
        case .invalidURL:
            return "Can not estaplish connection for now, please try again later!"
        }
    }
}

extension Error {
    var errorMessage: String {
        if let err = self as? NetworkError {
            return err.errorMessage
        } else {
            return self.localizedDescription
        }
    }
}
