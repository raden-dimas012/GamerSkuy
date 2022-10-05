//
//  Extension+Date.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 29/09/22.
//

import Foundation

extension Date {
   func getFormattedDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MMM d, yyyy"
        return dateformat.string(from: self)
    }
}
