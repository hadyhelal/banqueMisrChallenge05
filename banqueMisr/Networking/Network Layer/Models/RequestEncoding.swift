//
//  RequestEncoding.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//


import Foundation

enum RequestEncoding {
    case url
    case json
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
