//
//  String+readableDateString.swift
//  Movies
//
//  Created by Omar on 24/05/2022.
//

import Foundation

extension String {
    
    var readableDateString: String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: self) else { return "-" }
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: date)
    }
}
