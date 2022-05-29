//
//  Movie.swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import Foundation
import UIKit

// MARK: - Movie Model

struct Movie : Codable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case id, original_title, overview, popularity
        case poster_path, release_date, title, vote_average
        case genreData = "genre_ids", backdrop_path
        case homepage, revenue, status, tagline, videos, runtime
    }
    
    let id: Int
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let backdrop_path: String
    let release_date: String
    let title : String
    let vote_average: Double
    let genreData: GenreData?
 
    /** Movie details **/
    let homepage: String?
    let runtime: Int?
    let revenue: Int?
    let status: String?
    let tagline: String?
    let videos: VideoResult?
    
    /** Non-codable custom properties **/
    var trailerId: String {
        let id = videos?.results.first(where: { $0.type == "Trailer"})?.key
        return id ?? videos?.results.first?.key ?? ""
    }
    var releaseDate: String {
        return release_date.readableDateString
    }
    var voteAverageString: String {
        return String(format:"%.1f", vote_average)
    }
    var posterUrl: URL? {
        return URLFactory.imageURL(for: poster_path)
    }
    var backdropUrl: URL? {
        return URLFactory.imageURL(for: backdrop_path)
    }
}

// MARK:  Movie Child Models

struct VideoResult : Codable {
    let results: [Video]
}
struct Video: Codable {
    let id: String?
    let key: String?
    let published_at: String?
    let site: String?
    let type: String?
}

enum GenreData: Codable {
    
    case ids([Int])
    case objects([Genre])

    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if let genres = try? container.decode([Int].self) {
            self = .ids(genres)
            return
        }
        
        if let genres = try? container.decode([Genre].self) {
            self = .objects(genres)
            return
        }
        throw DecodingError.typeMismatch(GenreData.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GenreData"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .ids(let x):
            try container.encode(x)
        case .objects(let x):
            try container.encode(x)
        }
    }
}

struct Genre : Codable {
    let id: Int?
    let name: String?
}

