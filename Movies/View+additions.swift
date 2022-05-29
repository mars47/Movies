//
//  View+roundedCorners.swift
//  Movies
//
//  Created by Omar on 23/05/2022.
//

import SwiftUI
import Foundation

extension View {
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCornerView(radius: radius, corners: corners) )
    }
    
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    } //.navigate(to: MainPageView(), when: $willMoveToNextScreen)
}

struct RoundedCornerView: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Color {
    
    static var grouped : some View {
        Color.init(uiColor: UIColor(named: "Grouped")!)
    }
}
