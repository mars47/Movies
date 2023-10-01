//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    var movies: [Movie] = []
    @Published var isFetching = false
   
    func fetchUpcomingMovies() async {
        
        DispatchQueue.main.async {
            self.isFetching = true
        }
        
        guard let movies = await NetworkManager.fetchUpcomingMovies()?.movies else { 
            return
        }
        DispatchQueue.main.async {
            self.movies = movies
            self.isFetching = false
        }

    }
}
