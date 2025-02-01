//
//  PopularMoviesResponse.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

struct PopularMoviesResponse: Codable {
    let results: [MovieResult]?
}

struct MovieResult: Codable {
    let id: Int?
    let posterPath, releaseDate, title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
