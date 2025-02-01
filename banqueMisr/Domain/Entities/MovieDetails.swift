//
//  MovieDetails.swift
//  banqueMisr
//
//  Created by Hady Helal on 02/02/2025.
//


struct MovieDetails {
    let movieTitle: String
    let movieDescription: String
    let movieImage: String
    let genres: [Genre]
    let movieRunTime: String
}

extension MovieDetails {
    init(from model: MoviesDetailsResponse?) {
        self.movieTitle = model?.title ?? ""
        self.movieDescription = model?.overview ?? ""
        self.movieImage = "\(Helper.imagesURL)\(model?.posterPath ?? "")"
        self.genres = model?.genres?.compactMap{ Genre(from: $0)} ?? []
        self.movieRunTime = MovieDetails.formatMovieDuration(minutes: model?.runtime ?? 0)
    }
}



struct Genre: Identifiable {
    let id: Int
    let name: String
}

extension Genre {
    init?(from model: GenreResponse?) {
        guard let id = model?.id else { return nil }
        self.id = id
        self.name = model?.name ?? ""
    }
}

extension MovieDetails {
    private static func formatMovieDuration(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        if hours > 0 {
            return "\(hours)h \(remainingMinutes)m"
        } else {
            return "\(remainingMinutes)m"
        }
    }
    
    static let mockData = MovieDetails(movieTitle: "movie title",
                                       movieDescription: "movie description"
                                       , movieImage: "sdf",
                                       genres: [],
                                       movieRunTime: "1h, 40 sec")
}


