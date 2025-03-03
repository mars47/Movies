//
//  URLFactory .swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import Foundation

class URLFactory {
    
    static private var base : String {
        URLFactory.config()["base"] as! String
    }
    static private var bearerToken : String {
        URLFactory.config()["bearerToken"] as! String
    }
    
    static func upcomingMovies() -> URLRequest {
        
            let url = URL(string: "https://api.themoviedb.org/3/discover/movie")!
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
              URLQueryItem(name: "include_video", value: "true"),
              URLQueryItem(name: "language", value: "en-US"),
              URLQueryItem(name: "page", value: "1"),
              URLQueryItem(name: "primary_release_date.gte", value: Date().stringValue),
              URLQueryItem(name: "sort_by", value: "popularity.desc"),
            ]
            components.queryItems = (components.queryItems ?? []) + queryItems
            
        var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
              "accept": "application/json",
              "Authorization": "Bearer \(bearerToken)"
            ]
        return request
    }
    
    static func movieDetails(movieId: String) -> URLRequest {
        
        var urlString = base + ( config()["movieDetails"] as! String )
        urlString = urlString.replacingOccurrences(of: "{movieId}", with: movieId)
        
        var request = URLRequest(url: URL(string: urlString)!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
              "accept": "application/json",
              "Authorization": "Bearer \(bearerToken)"
            ]
        return request
    }
    
    static func imageURL(for id: String) -> URL? {
        
        var urlString = config()["imageURL"] as! String
        urlString = urlString.replacingOccurrences(of: "{imageId}", with: id)
        return URL(string: urlString)
    }
    
    static func config() -> NSDictionary {
        
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path)
        else {
            fatalError("Config.plist file not found")
        }
        return config
        //--no-skip-worktree Config.plist
    }
}


