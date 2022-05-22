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
    static private var api_key : String {
        URLFactory.config()["API_key"] as! String
    }
    
    static func upcomingMovies() -> URL {
        
        var urlString = base + ( config()["movies"] as! String )
        urlString = urlString.replacingOccurrences(of: "{key}", with: api_key)
        urlString = urlString.replacingOccurrences(of: "{date}", with: Date().stringValue)
        return URL(string: urlString)!
    }
    
    static func movieDetails(movieId: String) -> URL {
        
        var urlString = base + ( config()["movieDetails"] as! String )
        urlString = urlString.replacingOccurrences(of: "{key}", with: api_key)
        urlString = urlString.replacingOccurrences(of: "{movieId}", with: movieId)
        return URL(string: urlString)!
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


