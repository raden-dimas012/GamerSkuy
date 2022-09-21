//
//  DetailTrailerView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 12/09/22.
//

import SwiftUI
import AVKit

struct DetailTrailerView: View {
    var videoLink: String
    @State private var player = AVPlayer()
    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player = AVPlayer(url: URL(string: videoLink)!)
                player.play()
            }
            .onDisappear {
                player.pause()
            }
            .navigationBarTitle("Detail Trailer", displayMode: .inline)
    }
}
