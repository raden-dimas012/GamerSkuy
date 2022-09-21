//
//  TrailerCardView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 19/09/22.
//

import SwiftUI
import Kingfisher

struct TrailerCardView: View {
    let trailer: Trailer
    let constant: Constants
    var body: some View {
            ZStack {
                ZStack(alignment: .bottomLeading) {
                    KFImage.url(URL(string: trailer.preview))
                        .resizable()
                        .onSuccess { success in
                            debugPrint("success: \(success)")
                        }
                        .onFailure { error in
                            debugPrint("error: \(error)")
                        }
                        .placeholder { progress in
                            ProgressView(progress).frame(width: 125, height: 175)
                        }
                        .fade(duration: 0.35)
                        .frame(width: 200, height: 150)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                        .frame(width: 225, height: 175)
                }
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(50)
            }
    }
}
