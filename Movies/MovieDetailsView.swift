//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Omar on 25/05/2022.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailsViewModel
    var body: some View {
        
        if viewModel.isFetching {
            LoadingView()
        } else {
        
        VideoView(videoID: viewModel.movie.trailerId)
            .frame(minHeight:0, maxHeight: UIScreen.main.bounds.height / 3.5)
            .cornerRadius(12)
            .padding(.horizontal, 12)
             Spacer()
        }
    }
}
    

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsView()
//    }
//}
