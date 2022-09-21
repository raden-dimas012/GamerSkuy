//
//  DetailView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    var body: some View {
        VScrollView {
            VStack(spacing: 0) {
                if viewModel.gameDetail == nil {
                    LoadingView()
                } else {
                    topImageView
                    contentView
                    trailerView
                }
            }
            .onAppear {
                viewModel.getDetailGame(movieID: viewModel.id ?? 0)
                viewModel.getDetailMovieTrailer(movieID: viewModel.id ?? 0)
            }
        }
        .navigationBarTitle("Detail Movie", displayMode: .inline)
    }
    var topImageView: some View {
        KFImage.url(URL(string: viewModel.gameDetail?.backgroundImage ?? ""))
            .resizable()
            .onSuccess { success in
                debugPrint("success: \(success)")
            }
            .onFailure { error in
                debugPrint("error: \(error)")
            }
            .placeholder { progress in
                ProgressView(progress).frame(width: 330, height: 220)
            }
            .fade(duration: 0.35)
            .frame(width: 330, height: 220)
            .cornerRadius(25)
            .shadow(radius: 5)
            .frame(width: 360, height: 250)
            .padding(.top, 15)
    }
    var contentView: some View {
        VStack {
            Text("Title")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(viewModel.gameDetail?.name ?? "")
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
            Text(viewModel.helper?.getDetailGenres(genres: viewModel.gameDetail?.genres ?? []) ?? "")
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
            Text(viewModel.gameDetail?.released ?? "")
                .font(.system(size: 20))
                .italic()
                .fontWeight(.semibold)
                .padding(.leading, 15)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Overview")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(viewModel.helper?.handleStringNoValue(data: viewModel.gameDetail?.description ?? "") ?? "")
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
            Text(String(viewModel.gameDetail?.rating ?? 0.0) + "/10")
                .font(.system(size: 20))
                .italic()
                .fontWeight(.semibold)
                .padding(.leading, 15)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    var trailerView: some View {
        VStack(spacing: 0) {
            Text("Trailer")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            if !viewModel.gameTrailer.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 5) {
                        ForEach(viewModel.gameTrailer) { trailer in
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
}
