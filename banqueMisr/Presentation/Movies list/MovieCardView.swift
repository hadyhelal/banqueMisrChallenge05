//
//  MovieCardView.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import SwiftUI

struct MovieCardView: View {
    
    let movie: Movie

    var body: some View {
        ImageLoader(url: movie.image, contentMode: .fill)
            .aspectRatio(2/3, contentMode: .fill)
            .overlay {
                LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .bottom)
                    .opacity(0.7)
            }
            .overlay(alignment: .bottom) {
                postTitle
                    .padding(.leading, 8)
                    .padding(.bottom, 8)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
    
    private var postTitle: some View {
        VStack(alignment: .leading) {
            Text(movie.title.uppercased())
                .font(.title3)
                .fontWeight(.medium)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(movie.releaseDate)
                .font(.callout)
                .fontWeight(.medium)
                .lineLimit(1)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
        
}
