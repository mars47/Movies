//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Omar on 25/05/2022.
//

import Foundation

class MovieDetailsViewModel {
    
    @Published var movie: Movie!
    @Published var isFetching = false

    func fetchMovieDetails(id: String) async {
            
            isFetching = true
            guard let movie = await NetworkManager.fetchMovieDetails(id: id) else { return }
            DispatchQueue.main.async {
                self.movie = movie
                self.isFetching = false
            }
        }
}

