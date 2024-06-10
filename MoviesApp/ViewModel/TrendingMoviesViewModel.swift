//
//  TrendingMoviesViewModel.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 02/06/24.
//

import Foundation
import NetworkingFramework

@MainActor class MoviesViewModel: ObservableObject {

    // MARK: - Properties

    @Published var trendingMovies = [Movie]()
    @Published var popularMovies = [Movie]()
    @Published var isDataFetching: Bool = true
    @Published var isDataFetched: Bool = false
    @Published var error: NSError?

    // MARK: - API's

    func fetchTrendingMovies() {
        resetProperties()
        let trendingMoviesURL = URL(string: NetworkingAPIConstants.baseURL.rawValue
            + NetworkingAPIConstants.trendingMovies.rawValue
            + NetworkingAPIConstants.apiKey.rawValue)
        guard let trendingMoviesURL else {
            return
        }

        NetworkManager.shared.fetchData(from: trendingMoviesURL, completion: { [weak self] (result: Result<TrendingMovies, Error>) in
            guard let self else {
                MoviesAppLogger.sharedInstance.info("[TrendingMoviesViewModel] Self should be non nil")
                return
            }

            DispatchQueue.main.async {
                self.isDataFetching = false
            }
            switch result {
            case .success(let movies):
                if let movies = movies.results {
                    DispatchQueue.main.async {
                        self.isDataFetched = true
                    }
                    self.trendingMovies = movies
                    self.sortTrendingMoviesUsingRating()
                }
                break
            case .failure(let error):
                MoviesAppLogger.sharedInstance.info("[TrendingMoviesViewModel] While processing the json data, got an error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.error = error as NSError
                }
                break
            }
        })
    }

    func fetchPopularMovies() {
        resetProperties()
        let popularMoviesURL = URL(string: NetworkingAPIConstants.baseURL.rawValue
            + NetworkingAPIConstants.popularMovies.rawValue
            + NetworkingAPIConstants.apiKey.rawValue)
        guard let popularMoviesURL else {
            return
        }

        NetworkManager.shared.fetchData(from: popularMoviesURL, completion: { [weak self] (result: Result<TrendingMovies, Error>) in
            guard let self else {
                MoviesAppLogger.sharedInstance.info("[TrendingMoviesViewModel] Self should be non nil")
                return
            }

            DispatchQueue.main.async {
                self.isDataFetching = false
            }
            switch result {
            case .success(let movies):
                if let movies = movies.results {
                    DispatchQueue.main.async {
                        self.isDataFetched = true
                    }
                    self.popularMovies = movies
                    self.sortPopularMoviesUsingRating()
                }
                break
            case .failure(let error):
                MoviesAppLogger.sharedInstance.info("[TrendingMoviesViewModel] While processing the json data, got an error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.error = error as NSError
                }
                break
            }
        })
    }

    // MARK: - Private Helpers

    private func resetProperties() {
        self.isDataFetching = true
        self.isDataFetched = false
        self.error = nil
    }

    private func sortTrendingMoviesUsingRating() {
        self.trendingMovies.sort { movie1, movie2 in
            return sort(movie1: movie1, movie2: movie2)
        }
    }

    private func sortPopularMoviesUsingRating() {
        self.popularMovies.sort { movie1, movie2 in
            return sort(movie1: movie1, movie2: movie2)
        }
    }

    private func sort(movie1: Movie, movie2: Movie) -> Bool {
        if movie1.voteAverage == movie2.voteAverage {
            if let title1 = movie1.title, let title2 = movie2.title {
                return title1 < title2
            }
        }

        if let voteAverage1 = movie1.voteAverage, let voteAverage2 = movie2.voteAverage {
            return voteAverage1 > voteAverage2
        }

        return true
    }
}

/// Enum which provides URL's which gives data from server
enum NetworkingAPIConstants: String {

    case apiKey = "?api_key=909594533c98883408adef5d56143539"
    case baseURL = "https://api.themoviedb.org/3"
    case trendingMovies = "/trending/all/day"
    case popularMovies = "/movie/popular"

}
