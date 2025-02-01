//
//  NetworkHelper.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

extension Data {
    
    func convertTo<T: Decodable>(model: T.Type) -> T? {
        
        var decodedModel: T?
        
        do {
            let decoder = JSONDecoder()
            decodedModel = try decoder.decode(model.self, from: self)
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            let message = "Key '\(key)' not found, codingPath: \(context.codingPath)"
            print(message)
        } catch DecodingError.valueNotFound(let value, let context) {
            let message = "Value '\(value)' not found: \(context.debugDescription), codingPath: \(context.codingPath)"
            print(message)
        } catch DecodingError.typeMismatch(let type, let context) {
            let message = "Type '\(type)' mismatch: \(context.debugDescription), codingPath: \(context.codingPath)"
            print(message)
        } catch {
            let message = "error: \(error)"
            print(message)
        }
        
        return decodedModel
    }
    
    var toString: String {
        return String(data: self, encoding: .utf8) ?? ""
    }
}
