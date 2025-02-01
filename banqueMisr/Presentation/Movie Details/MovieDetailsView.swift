//
//  MovieDetailsView.swift
//  banqueMisr
//
//  Created by Hady Helal on 01/02/2025.
//

import SwiftUI

struct MovieDetailsView: View {

    @StateObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                ImageLoader(url: viewModel.movieDetails.movieImage)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                
                Text(viewModel.movieDetails.movieTitle)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text(viewModel.movieDetails.movieDescription)
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Text("Gener")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.movieDetails.genres) { gener in
                                Text(gener.name)
                                    .foregroundStyle(.red)
                                    .padding(8)
                                    .clipShape(Capsule())
                                    .overlay {
                                        Capsule().stroke(Color.red, lineWidth: 0.5)
                                    }
                            }
                        }
                    }
                }
                
                HStack {
                    Text("Movie Duration:")
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Text(viewModel.movieDetails.movieRunTime)
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.yellow)
                }
            }
        }
        .ignoresSafeArea()
        .task {
            await viewModel.getMovie()
        }

    }
}
//
//#Preview {
//    MovieDetailsView(viewModel: MovieDetailsViewModel(movieId: 12, useCase: Moied))
//        .environmentObject(ImageCacheManager())
//}
//
