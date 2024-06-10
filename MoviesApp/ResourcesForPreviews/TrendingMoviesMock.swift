//
//  TrendingMoviesMock.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 02/06/24.
//

import Foundation

class TrendingMoviesMock {

    // MARK: - TrendingMoviesMock

    static var stubbedTrendingMovies: [Movie] {
        let response: TrendingMovies? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return (response?.results)!
    }

    static var stubbedMovie: Movie {
        stubbedTrendingMovies[0]
    }

    static var stubbedMovieInfo: Movie {
        let movie: Movie? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_info")
        return movie!
    }
}

extension Bundle {

    // MARK: - Bundle

    func loadAndDecodeJSON<T: Decodable>(filename: String) throws -> T? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let decodedModel = try jsonDecoder.decode(T.self, from: data)
        return decodedModel
    }
}
