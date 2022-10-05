//
//  Extenstion+String.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 03/10/22.
//

import Foundation

extension String {
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d,yyyy"
        guard let date = dateFormatter.date(from: self) else {
          preconditionFailure("Take a look to your format")
        }
        return date
    }
}
