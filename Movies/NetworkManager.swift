//
//  NetworkManager.swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import Foundation

class NetworkManager {
    
    static func fetchUpcomingMovies() async -> Root? {
                
        do {
            let (data, _) = try await URLSession.shared.data(from: URLFactory.upcomingMovies())
            return try JSONDecoder().decode(Root.self, from: data)
        } catch {
            print("caught: \(error)")
        }
            return nil
    }
    
    static func fetchMovieDetails(movieId: String) async -> Movie? {
                
        do {
            let (data, _) = try await URLSession.shared.data(from: URLFactory.movieDetails(movieId: movieId))
            return try JSONDecoder().decode(Movie.self, from: data)
        } catch {
            print("caught: \(error)")
        }
            return nil
    }
}
