//
//  ContentView.swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import SwiftUI

struct MovieListView: View {
            
    @StateObject var viewModel = MovieListViewModel()
        
    var body: some View {
        
        NavigationView {
            
            if viewModel.isFetching {
                LoadingView()
            } else {
                List {
                    Section(header: Text("IN CINEMAS NOW")) {
                        
                        ForEach(viewModel.movies) { movie in
                            MovieItemView(movie:movie)
                                .listRowSeparator(.hidden)
                            Divider()
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                //.listStyle(.plain)
                .navigationBarTitle(Text("Latest Movies"), displayMode: .large)
            }
        }
        .task {
            await viewModel.fetchUpcomingMovies()
        }
    }
}

struct MovieItemView: View {
    
    var movie: Movie
    
    var body: some View {
        
        VStack(spacing:0) {
            
            ZStack(alignment: .topLeading){
                
                AsyncImage(url: movie.posterUrl) { image in
                    image.resizable().scaledToFill() }
                    placeholder: { ProgressView() }
                
                Text(movie.title)
                    .bold().padding().frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.65))
                
                let viewModel = MovieDetailsViewModel(movie: movie)
                NavigationLink(destination: MovieDetailsView(viewModel:viewModel)
                    .task {
                        await viewModel.fetchMovieDetails(id: "\(movie.id)")
                        await viewModel.fetchBackgroundImage(url: movie.backdropUrl)
                    }) { EmptyView() }.buttonStyle(PlainButtonStyle())
                
            }
            .cornerRadius(12, corners: [.topLeft, .topRight])
            .buttonStyle(BorderlessButtonStyle())
            
            VStack(spacing:8) {
                
                HStack() {
                    Text("Released: \(movie.releaseDate)").fontWeight(.light)
                    Spacer()
                    HStack() {
                        Text(movie.voteAverageString)
                        Image(systemName: "star.fill")
                    }
                    .foregroundColor(Color.yellow)
                }
                
                OverviewExpandView(movie: movie)
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(12, corners: [.bottomRight, .bottomLeft])
            .buttonStyle(BorderlessButtonStyle())
        }
        .shadow(radius: 2.5)
    }
}

struct OverviewExpandView: View {
    
    @State private var isCollapsed = true

    var movie: Movie
    var imageName: String {
        isCollapsed ? "plus" : "minus"
    }
    
    var body: some View {
        
        HStack {
            Text("Overview").bold()
            Spacer()
            Button(
                action: { isCollapsed.toggle() },
                label: { Image(systemName: imageName) } )
        }
        
        if isCollapsed {
            EmptyView()
        } else {
            Text(movie.overview).fontWeight(.light)
        }
    }
}

struct LoadingView: View {
    
    var body: some View {
        HStack {
            ProgressView()
                .padding(.trailing, 8)
            Text("Loading...")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

