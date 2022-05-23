//
//  Date+StringValue.swift
//  Movies
//
//  Created by Omar on 21/05/2022.
//

import Foundation

extension Date {
    
    var stringValue: String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
