//
//  MoviesTabView.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 02/06/24.
//

import SwiftUI

struct MoviesTabView: View {

    // MARK: - Properties

    @EnvironmentObject var moviesViewModel: MoviesViewModel

    // MARK: - View

    var body: some View {
        TabView() {
            MoviesListView(movies: moviesViewModel.trendingMovies, title: "Latest Movies")
                .environmentObject(moviesViewModel)
                .tabItem {
                    Image(systemName: "popcorn.fill")
                    Text("Latest Movies")
                }
                .onAppear {
                    moviesViewModel.fetchTrendingMovies()
                }
                .onDisappear {
                    moviesViewModel.trendingMovies = []
                }
            MoviesListView(movies: moviesViewModel.popularMovies, title: "Popular Movies")
                .environmentObject(moviesViewModel)
                .tabItem {
                    Image(systemName: "movieclapper.fill")
                    Text("Popular Movies")
                }
                .onAppear {
                    moviesViewModel.fetchPopularMovies()
                }
                .onDisappear {
                    moviesViewModel.popularMovies = []
                }
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    MoviesTabView()
}

#endif
