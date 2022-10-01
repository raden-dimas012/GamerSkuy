//
//  SearchViewModel.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 23/09/22.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var filteredGame: [Game] = []
    @Published var querySearch: String = ""
    var services: APIServicesProtocol?
    init(services: APIServicesProtocol) {
        self.services = services
    }
    deinit {
        self.services = nil
        debugPrint("Deinit SearchViewModel")
    }
    func searchGame(query: String) {
        guard let services = services else {return}
        services.getSearchGame(query: query) { [weak self] (result) in
            switch result {
            case .success(let games):
                DispatchQueue.main.async {
                    guard let self = self else {return}
                    self.filteredGame = games
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
