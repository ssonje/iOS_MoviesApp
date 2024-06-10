//
//  DetailMovieView.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 05/06/24.
//

import SwiftUI

struct MovieDetailView: View {

    // MARK: - Properties

    @ObservedObject var imageLoader = ImageLoader()
    let movie: Movie

    // MARK: - View

    var body: some View {
        ZStack {
            List {
                MovieThumbnailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

                HStack {
                    Image(systemName: "movieclapper")
                    Text(movie.genreString)
                    Text("·")
                    Text(movie.yearString)
                }

                HStack {
                    Image(systemName: "timer")
                    Text(movie.durationString)
                }

                HStack {
                    if let voteAverage = movie.voteAverage {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(String(format: "%.2f", voteAverage))")
                        }
                    }
                }

                HStack {
                    if let releaseDate = movie.releaseDate {
                        HStack {
                            Image(systemName: "calendar.circle")
                            Text(releaseDate)
                        }
                    }
                }

                Text(movie.overview ?? "n/a")

                HStack(alignment: .top, spacing: 4) {
                    if let movieCast = movie.cast, movieCast.count > 0 {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Starring").font(.headline)
                            ForEach(movieCast.prefix(9)) { cast in
                                Text(cast.name)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }

                    if let movieCrew = movie.crew, movieCrew.count > 0 {
                        VStack(alignment: .leading, spacing: 4) {
                            if movie.directors != nil && movie.directors!.count > 0 {
                                Text("Director(s)").font(.headline)
                                ForEach(self.movie.directors!.prefix(2)) { crew in
                                    Text(crew.name)
                                }
                            }

                            if let movieProducers = movie.producers, movieProducers.count > 0 {
                                Text("Producer(s)").font(.headline)
                                    .padding(.top)
                                ForEach(self.movie.producers!.prefix(2)) { crew in
                                    Text(crew.name)
                                }
                            }

                            if let movieScreenWriters = movie.screenWriters, movieScreenWriters.count > 0 {
                                Text("Screenwriter(s)").font(.headline)
                                    .padding(.top)
                                ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                    Text(crew.name)
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .navigationBarTitle(movie.title ?? "", displayMode: .inline)
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    MovieDetailView(movie: TrendingMoviesMock.stubbedMovieInfo)
}

#endif
