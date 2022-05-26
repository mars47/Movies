//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Omar on 25/05/2022.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    
    @Published var movie: Movie!
    @Published var isFetching = true

    func fetchMovieDetails(id: String) async {
            
            isFetching = true
            guard let movie = await NetworkManager.fetchMovieDetails(id: id) else { return }
            DispatchQueue.main.async {
                self.movie = movie
                self.isFetching = false
            }
        }
}

