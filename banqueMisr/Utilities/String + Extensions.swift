//
//  String + Extensions.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

extension String {
    func convertToReadableFormat(inputFormat: String = "yyyy-MM-dd") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
