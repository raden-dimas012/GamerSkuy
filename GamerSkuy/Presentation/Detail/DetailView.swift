//
//  DetailView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @StateObject var detailViewModel: DetailViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @Environment(\.managedObjectContext) var context
    @AppStorage("darkModeEnabled") private var darkModeEnabled: Bool = Theme.isNotDarkMode
    var body: some View {
        VScrollView {
            VStack(spacing: 0) {
                if detailViewModel.gameDetail == nil {
                    LoadingView()
                } else {
                    createTopImageView()
                    createContentView()
                    createDetailContentView()
                    createTrailerView()
                    createButtonFavorite()
                }
            }
            .onAppear {
                detailViewModel.getDetailGame(movieID: detailViewModel.id ?? 0)
                detailViewModel.getDetailMovieTrailer(movieID: detailViewModel.id ?? 0)
                favoriteViewModel.checkIsFavorite(id: detailViewModel.id ?? 0)
            }
        }
        .navigationBarTitle("Detail Movie", displayMode: .inline)
    }
    @ViewBuilder
    private func createTopImageView() -> some View {
        KFImage.url(URL(string: detailViewModel.gameDetail?.backgroundImage ?? ""))
            .resizable()
            .cacheMemoryOnly()
            .onSuccess { success in
                debugPrint("success: \(success)")
            }
            .onFailure { error in
                debugPrint("error: \(error)")
            }
            .placeholder { progress in
                ProgressView(progress).frame(width: 330, height: 220)
            }
            .cancelOnDisappear(true)
            .fade(duration: 0.35)
            .frame(width: 330, height: 220)
            .cornerRadius(25)
            .shadow(radius: 5)
            .frame(width: 360, height: 250)
            .padding(.top, 15)
    }
    @ViewBuilder
    private func createContentView() -> some View {
        VStack {
            Text("Title")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(detailViewModel.gameDetail?.name ?? "")
                .font(.system(size: 20))
                .italic()
                .fontWeight(.semibold)
                .padding(.leading, 15)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Genre")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(detailViewModel.helper?.getDetailGenres(genres: detailViewModel.gameDetail?.genres ?? []) ?? "")
                .font(.system(size: 20))
                .italic()
                .fontWeight(.semibold)
                .padding(.leading, 15)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Release")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(detailViewModel.gameDetail?.released ?? "")
                .font(.system(size: 20))
                .italic()
                .fontWeight(.semibold)
                .padding(.leading, 15)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    @ViewBuilder
    private func createDetailContentView() -> some View {
        VStack {
            Text("Overview")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(detailViewModel.helper?.handleStringNoValue(data: detailViewModel.gameDetail?.description ?? "") ?? "")
                .font(.system(size: 14))
                .italic()
                .fontWeight(.regular)
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Rating")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(String(detailViewModel.gameDetail?.rating ?? 0.0) + "/10")
                .font(.system(size: 20))
                .italic()
                .fontWeight(.semibold)
                .padding(.leading, 15)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    @ViewBuilder
    private func createTrailerView() -> some View {
        VStack(spacing: 0) {
            Text("Trailer")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            if !detailViewModel.gameTrailer.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 5) {
                        ForEach(detailViewModel.gameTrailer) { trailer in
                            NavigationLink(destination: DetailTrailerView(videoLink: trailer.trailerMovie.link)) {
                                VStack {
                                    TrailerCardView(trailer: trailer, constant: Constants())
                                    Text(trailer.name)
                                        .font(.headline)
                                        .bold()
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 200)
                                }
                            }
                        }
                    }
                }
                .frame(height: 200)
            } else {
                HStack(alignment: .center) {
                    Spacer()
                    Text("No Trailers")
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
    }
    @ViewBuilder
    private func createButtonFavorite() -> some View {
        Button {
            if favoriteViewModel.isFavorite {
                guard let gameDetail = detailViewModel.gameDetail else {return}
                favoriteViewModel.removeFromFavorite(context: context, id: gameDetail.id)
                favoriteViewModel.isFavorite = false
                detailViewModel.favoriteAlert = .removeFromFavorite
            } else {
                guard let gameDetail = detailViewModel.gameDetail else {return}
                favoriteViewModel.addFavorite(context: context, data: gameDetail)
                favoriteViewModel.isFavorite = true
                detailViewModel.favoriteAlert = .addToFavorite
            }
            detailViewModel.showFavoriteAlert.toggle()
        } label: {
            Label {
                Text(favoriteViewModel.isFavorite ? "Remove From Favorite" : "Add To Favorite")
            } icon: {
                Image(systemName: favoriteViewModel.isFavorite ? "heart.fill" : "heart")
            }
            .foregroundColor(darkModeEnabled ? .black : .white)
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(darkModeEnabled ? .gray : .black, in: Capsule())
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity)
        .alert(isPresented: $detailViewModel.showFavoriteAlert) {
            createAlertFavorite()
        }
    }
    private func createAlertFavorite() -> Alert {
        switch detailViewModel.favoriteAlert {
        case .addToFavorite:
            return Alert(
                title: Text("Success"),
                message: Text("Data Added To Favorite."),
                dismissButton: .default(Text("Ok"))
            )
        case .removeFromFavorite:
            return Alert(
                title: Text("Success"),
                message: Text("Data Removed From Favorite."),
                dismissButton: .default(Text("Ok"))
            )
        default:
            return Alert(
                title: Text("Something Went Wrong"),
                message: Text("Error..."),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
}
