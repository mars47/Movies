//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Omar on 25/05/2022.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    
    @Published var movie: Movie
    @Published var isFetching = true

    var isTaglineEnabled : Bool {
        movie.tagline != nil ? true : false 
    }
    
    var tagline: String {
        "\"\(movie.tagline!)\""
    }

    init(movie: Movie) {
        self.movie = movie
    }
        
    func fetchMovieDetails(id: String) async {
            
            guard let movie = await NetworkManager.fetchMovieDetails(movieId: id) else { return }
            DispatchQueue.main.async {
                self.movie = movie
                self.isFetching = false
            }
        }
}

