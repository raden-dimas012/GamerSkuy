//
//  Responses.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import Foundation

struct ResponsesGame: Codable {
    let results: [Game]
}

struct ResponsesGenre: Codable {
    let results: [Genre]
}

typealias ResponsesGameDetail = GameDetail

struct ResponsesTrailer: Codable {
    let results: [Trailer]
}
