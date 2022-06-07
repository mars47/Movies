//
//  ExpandingView.swift
//  Movies
//
//  Created by Omar on 07/06/2022.
//

import Foundation
import SwiftUI

struct ExpandingView: View {
    
    @State private var isCollapsed = true

    var title: String
    var text: String
    var imageName: String {
        isCollapsed ? "plus" : "minus"
    }
    
    var body: some View {
        
        HStack {
            Text(title).bold()
            Spacer()
            Button(
                action: { isCollapsed.toggle() },
                label: { Image(systemName: imageName) } )
        }
        
        if isCollapsed {
            EmptyView()
        } else {
            Text(text).fontWeight(.light)
        }
    }
}
