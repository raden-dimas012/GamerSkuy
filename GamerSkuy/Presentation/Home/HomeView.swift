//
//  ContentView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 09/09/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.genres.isEmpty && viewModel.games.isEmpty {
                LoadingView()
            } else {
                createCategoryView()
                if viewModel.games.isEmpty {
                    Spacer()
                    LoadingView()
                    Spacer()
                } else {
                    createListGameView()
                }
            }
        }
        .onAppear {
            viewModel.getGenres()
            viewModel.getGames(genreID: viewModel.selectedGenre, page: viewModel.currentPage)
        }
    }
    @ViewBuilder
    private func createCategoryView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.genres) { genre in
                    CategoryCardView(genre: genre, isSelected: viewModel.selectedGenre == genre.id)
                        .environmentObject(viewModel)
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 16)
            .drawingGroup()
        }
    }
    @ViewBuilder
    private func createListGameView() -> some View {
        List {
            ForEach(viewModel.games) { game in
                NavigationLink(destination: DetailView(detailViewModel: DetailViewModel(
                    id: game.id ?? 0, services: APIServices(constant: Constants()),
                    constant: Constants(), helper: Helper())).environmentObject(favoriteViewModel)
                ) {
                        MovieCardView(fromFavorite: false, game: game, favoriteGame: nil, helper: Helper())
                        .drawingGroup()

                    }
                if game == viewModel.games.last {
                    LoadingView()
                        .onAppear {
                            DispatchQueue.main.async {
                                viewModel.currentPage += 1
                                viewModel.getGames(genreID: viewModel.selectedGenre,
                                                   page: viewModel.currentPage)
                            }
                        }
                }
            }
        }
        .listStyle(.plain)
    }
}
