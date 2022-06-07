//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Omar on 25/05/2022.
//

import Foundation
import UIKit

class MovieDetailsViewModel: ObservableObject {
    
    @Published var movie: Movie
    @Published var isFetching = true
    @Published var image: UIImage?
    let videoHeight = UIScreen.main.bounds.height / 3.5
    
    var isBackgoundImageDownloaded: Bool {
        image != nil
    }
    
    var isTaglineEnabled : Bool {
        movie.tagline != nil 
    }
    
    var tagline: String {
        "- \"\(movie.tagline!)\""
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
    
    func fetchBackgroundImage(url: URL?) async {
        
        guard
            let url = url,
            let image = await NetworkManager.fetchImage(for: url)
        else { return }
        
        DispatchQueue.main.async {
            self.image = image 
        }
        
    }
}

