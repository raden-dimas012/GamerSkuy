//
//  CategoryCardView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 12/09/22.
//

import SwiftUI

struct CategoryCardView: View {
    @Namespace private var animation
    @EnvironmentObject var viewModel: HomeViewModel
    @AppStorage("darkModeEnabled") private var darkModeEnabled: Bool = Theme.isNotDarkMode
    let genre: Genre
    let isSelected: Bool
    var body: some View {
        Text(genre.name)
            .font(.callout)
            .fontWeight(.semibold)
            .scaleEffect(0.9)
            .foregroundColor(
                darkModeEnabled ? viewModel.selectedGenre == genre.id ? .black : .white
                : viewModel.selectedGenre == genre.id ? .white : .black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background {
                if viewModel.selectedGenre == genre.id {
                    Capsule()
                        .fill(darkModeEnabled ? .gray : .black)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                }
            }
            .contentShape(Capsule())
            .onTapGesture {
                withAnimation {
                    viewModel.selectedGenre = genre.id
                    viewModel.games.removeAll()
                    viewModel.currentPage = 1
                    viewModel.getGames(genreID: viewModel.selectedGenre,
                                       page: viewModel.currentPage)
                }
            }
    }
}
