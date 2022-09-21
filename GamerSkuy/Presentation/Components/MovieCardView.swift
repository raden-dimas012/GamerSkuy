//
//  MovieCardView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import SwiftUI
import Kingfisher

struct MovieCardView: View {
    let game: Game
    let constant: Constants
    let helper: Helper
    var body: some View {
        HStack {
            KFImage.url(URL(string: game.backgroundImage))
                .resizable()
                .onSuccess { success in
                    debugPrint("success: \(success)")
                }
                .onFailure { error in
                    debugPrint("error: \(error)")
                }
                .placeholder { progress in
                    ProgressView(progress).frame(width: 150)
                }
                .fade(duration: 0.35)
                .frame(width: 100, height: 150)
                .cornerRadius(25)
                .shadow(radius: 5)
                .frame(width: 125, height: 175)
            VStack(alignment: .leading, spacing: 8) {
                Text(String(game.rating))
                    .font(.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text(game.name)
                    .font(.system(size: 12))
                    .bold()
                    .padding(.bottom, 8)
                Text(helper.getGenres(genres: game.genres))
                    .font(.system(size: 10))
                    .padding(.bottom, 8)
                Text(game.released)
                    .font(.system(size: 10))
                    .padding(.bottom, 8)
                Spacer()
            }
            .padding(.top, 8)
            .padding(.trailing, 8)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
