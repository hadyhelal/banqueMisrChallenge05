//
//  MoviesDetailsResponse.swift
//  banqueMisr
//
//  Created by Hady Helal on 02/02/2025.
//

import Foundation

struct MoviesDetailsResponse: Codable {
    let genres: [GenreResponse]?
    let title: String?
    let overview: String?
    let posterPath: String?
    let runtime: Int?

    enum CodingKeys: String, CodingKey {
        case genres, title, overview, runtime
        case posterPath = "poster_path"
    }
}

struct GenreResponse: Codable {
    let id: Int?
    let name: String?
}
