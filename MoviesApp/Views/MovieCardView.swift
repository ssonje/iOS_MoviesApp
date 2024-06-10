//
//  MovieCardView.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 02/06/24.
//

import SwiftUI

struct MovieCardView: View {

    // MARK: - Properties

    @ObservedObject var imageLoader = ImageLoader()

    let movie: Movie

    // MARK: - View

    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))

                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                }
            }
            .frame(width: 100, height: 100)
            .cornerRadius(25)
            .shadow(radius: 5)

            VStack(alignment: .leading) {
                if let imageTitle = movie.title {
                    Text(imageTitle)
                        .bold()
                        .lineLimit(2)
                } else {
                    Text("Loading...")
                        .bold()
                }

                if let releaseDate = movie.releaseDate {
                    HStack {
                        Image(systemName: "movieclapper")
                        Text("\(releaseDate)")
                    }
                } else {
                    Text("Loading...")
                }

                if let voteAverage = movie.voteAverage {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(String(format: "%.2f", voteAverage))")
                    }
                } else {
                    Text("Loading...")
                }
            }
        }
        .onAppear {
            if let imageURL = movie.backdropURL {
                imageLoader.loadImage(with: imageURL)
            }
        }
        .frame(height: 110)
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    MovieCardView(movie: TrendingMoviesMock.stubbedTrendingMovies[1])
}

#endif
