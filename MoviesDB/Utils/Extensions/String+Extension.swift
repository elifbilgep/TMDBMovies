//
//  String+Extension.swift
//  MoviesDB
//
//  Created by Elif Parlak on 14.01.2025.
//

import Foundation
extension String {
    func toFormattedDate(inputFormat: String = "yyyy-MM-dd", outputFormat: String = "d MMMM yyyy") -> String? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = inputFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }
}
