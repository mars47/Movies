//
//  ContentView.swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import SwiftUI

struct MovieListView: View {
    
    var viewModel = MovieListViewModel()
    var body: some View {
        
        NavigationView {
            
            Text("Hello, world!")
                .padding()
        }
        .task {
            await viewModel.fetchUpcomingMovies()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
