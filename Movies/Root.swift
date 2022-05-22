//
//  Root.swift
//  Movies
//
//  Created by Omar on 23/05/2022.
//

import Foundation

struct Root : Codable {
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    let movies : [Movie]
}
