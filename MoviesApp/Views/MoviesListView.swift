//
//  MoviesListView.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 02/06/24.
//

import SwiftUI

struct MoviesListView: View {

    // MARK: - Properties

    @EnvironmentObject var moviesViewModel: MoviesViewModel
    let movies: [Movie]
    let title: String

    // MARK: - View

    var body: some View {
        NavigationView {
            ZStack {
                if !moviesViewModel.isDataFetched {
                    LoadingView() {
                        moviesViewModel.fetchTrendingMovies()
                    }
                    .environmentObject(moviesViewModel)
                } else {
                    List {
                        ForEach(movies, id: \.self) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie).environmentObject(moviesViewModel)) {
                                MovieCardView(movie: movie)
                            }
                        }
                        .navigationTitle(title)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    MoviesListView(movies: TrendingMoviesMock.stubbedTrendingMovies,
    title: "Trending Movies")
}

#endif

