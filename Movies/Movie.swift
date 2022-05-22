//
//  Movie.swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import Foundation

// MARK: - Movie Model

struct Movie : Codable {
    
    let id: Int?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title : String?
    let vote_average: Double?
    let genre_ids: GenreData?
    
    let homepage: String?
    let revenue: Int?
    let status: String?
    let tagline: String?
    let videos: [VideoResult]?
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
}

enum GenreData: Codable {
    
    case ints([Int])
    case objects([Genre])

    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if let genres = try? container.decode([Int].self) {
            self = .ints(genres)
            return
        }
        
        if let genres = try? container.decode([Genre].self) {
            self = .objects(genres)
            return
        }
        throw DecodingError.typeMismatch(GenreData.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MyGenre"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .ints(let x):
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

