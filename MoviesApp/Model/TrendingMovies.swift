//
//  TrendingMovies.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 02/06/24.
//

import Foundation

public struct TrendingMovies: Decodable {

    let page: Int?
    let results: [Movie]?

    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
    }
}
