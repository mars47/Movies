//
//  StretchyHeaderView.swift
//  Movies
//
//  Created by Omar on 07/06/2022.
//

import Foundation
import SwiftUI

struct StretchyHeaderView: View {
    
    var backgroundImage: Image
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let isHeaderBeingStretched = !(geometry.frame(in: .global).minY <= 0)
            
            ZStack {
                
                if isHeaderBeingStretched {
                    backgroundImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                        .clipped()
                        .offset(y: -geometry.frame(in: .global).minY)
                    
                } else {
                    backgroundImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(y: geometry.frame(in: .global).minY/9)
                        .clipped()
                }
            }
            
        }.frame(height: 400)
    }
}
