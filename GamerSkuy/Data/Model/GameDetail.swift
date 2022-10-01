//
//  GameDetail.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

struct GameDetail: Codable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let genres: [GameDetailGenre]
    let description: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case genres
        case description = "description_raw"
    }
}

struct GameDetailGenre: Codable {
    let id: Int
    let name: String
}
