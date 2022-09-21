//
//  CategoryCardView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 12/09/22.
//

import SwiftUI

struct CategoryCardView: View {
    var genre: Genre
    var isSelected: Bool
    var body: some View {
        Text(genre.name)
            .fontWeight(isSelected ? .semibold : .regular)
            .foregroundColor(isSelected ? .white: .black)
            .padding(10)
            .background(.gray)
            .cornerRadius(10)
    }
}
