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
                    Section(header: Text("Upcoming Movies In Cinemas")) {
                        ForEach(viewModel.movies) { movie in
                            MovieItemView(movie: movie)
                        }
                    }
                }
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
        
        ZStack(alignment: .topLeading){
            AsyncImage(url: movie.imageUrl) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 8)
            Text(movie.title)
                .bold()
                .listRowSeparator(.hidden)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.65))
        }
        .listRowInsets(EdgeInsets())
        HStack {
            Text("Release Date: \(movie.release_date)")
            Spacer()
        }
        .listRowSeparator(.hidden)

        OverviewExpandView(movie: movie)
        Divider()
    }
}

struct OverviewExpandView: View {
    
    var movie: Movie
    @State private var isCollapsed = true
    
    var imageName: String {
        isCollapsed ? "plus" : "minus"
    }
    
    var body: some View {
        
        HStack{
            Text("Overview")
            Spacer()
            Button(
                action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        isCollapsed.toggle()
                    }
                },
                label: {
                    Image(systemName: imageName)
                }
            )
            
            if isCollapsed {
                EmptyView()
            } else {
                Text(movie.overview)
                    .fontWeight(.regular)
                    
            }
        }
        .listRowSeparator(.hidden)
        
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
