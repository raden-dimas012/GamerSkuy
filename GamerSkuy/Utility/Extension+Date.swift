//
//  Extension+Date.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 29/09/22.
//

import Foundation

extension Date {
   func getFormattedDate(format: String = "MMM d, yyyy") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
