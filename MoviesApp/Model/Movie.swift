//
//  Movie.swift
//  MoviesApp
//
//  Created by Sanket Sonje  on 02/06/24.
//

import Foundation

struct Movie: Decodable, Hashable {

    // MARK: - API Data

    let id: Int?
    let title: String?
    let overview: String?
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Float?
    let voteCount: Int?
    let runtime: Int?
    let genres: [MovieGenre]?
    let credits: MovieCredit?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "original_title"
        case overview = "overview"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case runtime = "runtime"
        case genres = "genres"
        case credits = "credits"
    }

    // MARK: - Computed Properties

    var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")
    }

    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }

    var yearString: String {
        guard let releaseDate = self.releaseDate, let date = Self.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }

    var genreString: String {
        genres?.first?.name ?? "n/a"
    }

    var durationString: String {
        guard let runtime = runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.movieDurationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }

    var cast: [MovieCast]? {
        credits?.cast
    }

    var crew: [MovieCrew]? {
        credits?.crew
    }

    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }

    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }

    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }

    // MARK: - Private Helper

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()

    private static let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()

    private static let movieDurationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()

    // MARK: - Decodable

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
