//
//  FavoriteView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 23/09/22.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var viewModel: FavoriteViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        VStack {
            if viewModel.favoriteGame.isEmpty {
                NoDataView(title: "No Data Game Favorite is Found.....")
                    .onAppear {
                        viewModel.getDataFromCoreData(context: context)
                    }
            } else {
                List {
                    ForEach(viewModel.favoriteGame) { game in
                        NavigationLink(destination: DetailView(detailViewModel: DetailViewModel(
                            id: game.id ?? 0, services: APIServices(constant: Constants()),
                            constant: Constants(), helper: Helper())).environmentObject(viewModel)
                        ) {
                            MovieCardView(fromFavorite: true, game: nil, favoriteGame: game, helper: Helper())
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}
