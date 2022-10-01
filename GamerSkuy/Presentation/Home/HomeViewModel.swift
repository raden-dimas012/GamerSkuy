//
//  HomeViewModel.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var games: [Game] = [Game]()
    @Published var genres: [Genre] = [Genre]()
    @Published var selectedGenre: Int = 4
    @Published var currentPage: Int = 1
    private var services: APIServicesProtocol?
    init(services: APIServicesProtocol) {
        self.services = services
    }
    deinit {
        self.services = nil
        debugPrint("Deinit HomeViewModel")
    }
    func getGenres() {
        guard let services = services else {return}
        services.getGenres { [weak self] (result) in
            switch result {
            case .success(let genres):
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.genres = genres
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    func getGames(genreID: Int, page: Int) {
        guard let services = services else {return}
        services.getGames(genreID: genreID, page: page) { [weak self] (result) in
            switch result {
            case .success(let games):
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.games.append(contentsOf: games)
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
