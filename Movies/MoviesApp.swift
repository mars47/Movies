//
//  MoviesApp.swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieListViewModel())
        }
    }
}
