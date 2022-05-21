//
//  URLFactory .swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import Foundation

class URLFactory {
    
    var base = ""
    var api_key = ""
    
    init() {
        base = config()["base"] as! String
        api_key = config()["API_key"] as! String
    }
    
    func movies() -> URL! {
        
         var urlString = base + ( config()["movies"] as! String )
         urlString = urlString.replacingOccurrences(of: "{key}", with: "\(api_key)")
         urlString = urlString.replacingOccurrences(of: "{date}", with: Date().stringValue)
         return URL(string: urlString)
    }
    
    func movieDetails(movieId: String) -> URL! {
        
         var urlString = base + ( config()["movieDetails"] as! String )
         urlString = urlString.replacingOccurrences(of: "{key}", with: "\(api_key)")
         urlString = urlString.replacingOccurrences(of: "{movieId}", with: movieId)
         return URL(string: urlString)
    }
    
    private func config() -> NSDictionary {
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path)
        else {
            fatalError("Config.plist file not found")
        }
        return config
    }
}


