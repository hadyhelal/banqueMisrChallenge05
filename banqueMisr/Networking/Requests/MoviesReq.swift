//
//  MoviesReq.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

enum MoviesReq {

    struct FetchNowPlayingMovies: APIRequest {
        let path: String = "movie/now_playing"
    }
    
    struct FetchUpComingMovies: APIRequest {
        let path: String = "movie/upcoming"
    }
    
    struct FetchPopularMovies: APIRequest {
        let path: String = "movie/popular"
    }
    
    struct FetchMovieDetails: APIRequest {
        let path: String
        init(movieId: Int) {
            self.path = "movie/\(movieId)"
        }
    }
}
