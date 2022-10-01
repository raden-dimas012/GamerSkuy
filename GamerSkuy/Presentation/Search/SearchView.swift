//
//  SearchView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 23/09/22.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    var body: some View {
        VStack {
            SearchBarView()
                .environmentObject(viewModel)
            if viewModel.querySearch.isEmpty {
                NoDataView(title: "Please Search Your Game Through Search Bar.....")
            } else {
                if viewModel.filteredGame.isEmpty {
                    NoDataView(title: "No Data Game is Found.....")
                } else {
                    List {
                        ForEach(viewModel.filteredGame) { game in
                            NavigationLink(destination: DetailView(detailViewModel: DetailViewModel(
                                id: game.id ?? 0, services: APIServices(constant: Constants()),
                                constant: Constants(), helper: Helper())).environmentObject(favoriteViewModel)
                            ) {
                                MovieCardView(fromFavorite: false, game: game, favoriteGame: nil, helper: Helper())
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}
