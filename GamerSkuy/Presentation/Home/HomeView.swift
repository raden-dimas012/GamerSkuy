//
//  ContentView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 09/09/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.genres.isEmpty && viewModel.games.isEmpty {
                LoadingView()
            } else {
                SearchBarView(viewModel: viewModel)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.genres) { genre in
                            CategoryCardView(genre: genre, isSelected: viewModel.selectedGenre == genre.id)
                                .onTapGesture {
                                    withAnimation(.linear) {
                                        viewModel.selectedGenre = genre.id
                                        viewModel.games.removeAll()
                                        viewModel.filteredGames.removeAll()
                                        viewModel.currentPage = 1
                                        viewModel.getGames(genreID: viewModel.selectedGenre,
                                                           page: viewModel.currentPage)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                            viewModel.getFilteredGame(query: viewModel.querySearch)
                                        })
                                    }
                                }
                        }
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 16)
                }
                if viewModel.games.isEmpty && viewModel.filteredGames.isEmpty {
                    Spacer()
                    LoadingView()
                    Spacer()
                } else {
                    List {
                        if viewModel.querySearch.isEmpty {
                            ForEach(viewModel.games) { game in
                                NavigationLink(destination: DetailView(viewModel: DetailViewModel(
                                    id: game.id, services: APIServices(constant: Constants()),
                                    constant: Constants(), helper: Helper()))) {
                                        MovieCardView(game: game, constant: Constants(), helper: Helper())
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
                        } else {
                            if viewModel.filteredGames.isEmpty {
                                GeometryReader { geometry in
                                    VStack {
                                        Text("No Data")
                                    }
                                    .frame(width: geometry.size.width)
                                    .frame(minHeight: geometry.size.height)
                                }
                            } else {
                                ForEach(viewModel.filteredGames) { game in
                                    NavigationLink(destination: DetailView(viewModel: DetailViewModel(
                                        id: game.id, services: APIServices(constant: Constants()),
                                        constant: Constants(), helper: Helper()))) {
                                            MovieCardView(game: game, constant: Constants(), helper: Helper())
                                        }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .onAppear {
            viewModel.getGenres()
            viewModel.getGames(genreID: viewModel.selectedGenre, page: viewModel.currentPage)
        }
    }
}
