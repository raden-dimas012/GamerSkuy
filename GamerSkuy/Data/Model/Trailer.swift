//
//  Trailer.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 19/09/22.
//

struct Trailer: Codable, Identifiable {
    let id: Int
    let name: String
    let preview: String
    let trailerMovie: TrailerMovie
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case preview
        case trailerMovie = "data"
    }
}

struct TrailerMovie: Codable {
    let resolution: String
    let link: String
    enum CodingKeys: String, CodingKey {
        case resolution = "480"
        case link = "max"
    }
}
