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
                            MovieItemView(movie: movie).listRowSeparator(.hidden)
                            Divider().padding(.top, -8)
                        }
                    }
                }
                .listStyle(.plain)
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
    let viewModel = MovieDetailsViewModel()
    @State private var isShowingDetailView = false
    
    var body: some View {
        VStack(alignment:.leading ,spacing: 8) {
            
            ZStack(alignment: .topLeading){
                
                AsyncImage(url: movie.imageUrl) { image in
                    image.resizable().scaledToFill() }
                    placeholder: { ProgressView() }
                
                Text(movie.title)
                    .bold().padding().frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.65))
                
                NavigationLink(destination: MovieDetailsView(viewModel: viewModel)
                    .task {
                        viewModel.movie = movie
                        await viewModel.fetchMovieDetails(id: "\(movie.id)")
                    }) { EmptyView() }.buttonStyle(PlainButtonStyle())
            
            }
            .cornerRadius(12)
           
            HStack() {
                Text("Released: \(movie.releaseDate)").fontWeight(.light)
                Spacer()
                HStack() {
                    Text(movie.voteAverageString).fontWeight(.light)
                    Image(systemName: "star.fill")
                }
                    .foregroundColor(Color.yellow)
            }   .padding(.bottom, -8)
        }
            OverviewExpandView(movie: movie)
    }
}

struct OverviewExpandView: View {
    
    var movie: Movie
    @State private var isCollapsed = true
    
    var imageName: String {
        isCollapsed ? "plus" : "minus"
    }
    
    var body: some View {
        
        HStack {
            Text("Overview").bold()
            Spacer()
            Button(
                action: { withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) { isCollapsed.toggle() }},
                label: { Image(systemName: imageName) } )
        }

        if isCollapsed {
            EmptyView()
        } else {
            Text(movie.overview)
                .fontWeight(.light)
                .padding(.top, -8)
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
        MovieListView(viewModel: MovieListViewModel())
    }
}

