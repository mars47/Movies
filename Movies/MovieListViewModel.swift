//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    @Published var movies: [Movie]?
    
    func fetchUpcomingMovies() async {
        
        movies = await NetworkManager.fetchUpcomingMovies()?.movies
    }
}
