//
//  Game.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import Foundation

struct Game: Codable, Identifiable, Equatable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        let areEqual = lhs.id == rhs.id
        return areEqual
    }
    let id: Int
    let name: String
    let backgroundImage: String
    let released: String
    let rating: Double
    let genres: [GameGenre]
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case released
        case rating
        case genres
    }
}

struct GameGenre: Codable {
    let id: Int
    let name: String
}
