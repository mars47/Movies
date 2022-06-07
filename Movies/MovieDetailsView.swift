//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Omar on 25/05/2022.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailsViewModel

    var backgroundImage: Image {
        viewModel.isBackgoundImageDownloaded ? Image(uiImage: viewModel.image!) : Image(systemName: "person")
    }
    
    var body: some View {
        
        ScrollView {
            
            StretchyHeaderView(backgroundImage: backgroundImage)
            VStack(spacing: 0) {
                titleView
                videoView()
            }
            .padding(.top, -16)
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top)
    }
    
    var taglineView: AnyView {
        
        viewModel.isTaglineEnabled ?
        AnyView(Text(viewModel.tagline)
            .fontWeight(.light)
            .font(.subheadline.italic())) :
        AnyView(ProgressView())
    }
    
    var titleView: some View {
        
        HStack() {
        
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.movie.title).font(.title3)
                taglineView
            }.padding()
            Spacer()
        }
    }
    
    func videoView() -> some View {
        
        if viewModel.isFetching {
            return AnyView ( ZStack{
                 RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.init(uiColor: .lightGray)).opacity(0.65)
                    .padding(.horizontal, 12)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
                ProgressView { Text("Loading...").font(.title2) }
            } )
            
        } else {
            
            return AnyView(VideoView(videoID: viewModel.movie.trailerId)
                .frame(minHeight: viewModel.videoHeight, maxHeight: viewModel.videoHeight)
                .cornerRadius(12)
                .padding(EdgeInsets(top: -8, leading: 12, bottom: 0, trailing: 12)) )
        }
    }
}

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsView()
//    }
//}
