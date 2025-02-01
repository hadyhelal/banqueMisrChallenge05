//
//  Movie.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

struct Movie: Identifiable, Equatable {
    let id: Int
    let image: String
    let title: String
    let releaseDate: String
}

extension Movie {
    
    init?(from model: MovieResult?) {
        guard let id = model?.id else { return nil}
        self.id = id
        self.image = "\(Helper.imagesURL)\(model?.posterPath ?? "")"
        self.title = model?.title ?? ""
        self.releaseDate = model?.releaseDate?.convertToReadableFormat() ?? "N/A"
    }
    
    init(from model: CDMovie) {
        self.id = Int(model.id)
        self.image = "\(Helper.imagesURL)\(model.image ?? "")"
        self.title = model.title ?? ""
        self.releaseDate = model.releaseDate ?? ""
    }

}

extension Array where Element == Movie {
    static let tempMovies = [
        Movie(id: 1, image: "",
              title: "Movie bazora kasora mini alphabetic sourceing", releaseDate: "15-07-2022"),
        Movie(id: 2, image: "",
              title: "Apilit movib sdkdnfasdfjl", releaseDate: "15-07-2022"),
        Movie(id: 3, image: "",
              title: "Movie d", releaseDate: "15-07-2022"),
        Movie(id: 4, image: "",
              title: "Movie c", releaseDate: "15-07-2022"),
        Movie(id: 55, image: "",
              title: "Movie As", releaseDate: "15-07-2022"),
        Movie(id: 6, image: "",
              title: "Movie A", releaseDate: "15-07-2022"),
        Movie(id: 7, image: "",
              title: "Movie A", releaseDate: "15-07-2022"),
        Movie(id: 8, image: "",
              title: "Movie A", releaseDate: "15-07-2022"),
        Movie(id: 9, image: "",
              title: "Movie A", releaseDate: "15-07-2022"),
        Movie(id: 24, image: "",
              title: "Movie A", releaseDate: "15-07-2022"),
        Movie(id: 22, image: "",
              title: "Movie A", releaseDate: "15-12-2022")
    ]
}
