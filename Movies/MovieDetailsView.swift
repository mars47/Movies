//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Omar on 25/05/2022.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailsViewModel
    
    var TaglineView: AnyView {
        
        viewModel.isTaglineEnabled ?
        AnyView(Text(viewModel.tagline)
            .fontWeight(.light)
            .font(.body.italic())) :
        AnyView(ProgressView())
    }
    
    var body: some View {

        HStack(spacing: 8){
            VStack(alignment: .leading) {
                Text(viewModel.movie.title).font(.title)
                TaglineView
            }.padding()
                
            Spacer()
        }

        if viewModel.isFetching {
            ZStack{
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.init(uiColor: .lightGray)).opacity(0.65)
                    .padding(.horizontal, 12)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
                ProgressView { Text("Loading...").font(.title2) }
            }

        } else {

            VideoView(videoID: viewModel.movie.trailerId)
                .frame(minHeight:0, maxHeight: UIScreen.main.bounds.height / 3.5)
                .cornerRadius(12).padding(.horizontal, 12)
        }

        Spacer()
        Spacer()
        Text("")
    }
}
    

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsView()
//    }
//}
