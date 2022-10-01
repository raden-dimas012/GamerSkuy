//
//  DetailViewModel.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import CoreData

final class DetailViewModel: ObservableObject {
    @Published var gameDetail: GameDetail?
    @Published var gameTrailer: [Trailer] = [Trailer]()
    @Published var favoriteAlert: FavoriteAlerts?
    @Published var showFavoriteAlert: Bool = false
    private var services: APIServicesProtocol?
    private var constant: Constants?
    var helper: Helper?
    var id: Int?
    private let coreDataManager = CoreDataManager.shared
    init(id: Int, services: APIServicesProtocol, constant: Constants, helper: Helper) {
        self.id = id
        self.services = services
        self.constant = constant
        self.helper = helper
    }
    deinit {
        self.id = nil
        self.services = nil
        self.constant = nil
        self.helper = nil
        debugPrint("Deinit DetailViewModel")
    }
    func getDetailGame(movieID: Int) {
        guard let services = services else {return}
        services.getGameDetail(movieID: movieID) { [weak self] (result) in
            switch result {
            case .success(let gameDetail):
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.gameDetail = gameDetail
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    func getDetailMovieTrailer(movieID: Int) {
        guard let services = services else {return}
        services.getTrailer(movieID: movieID) { [weak self] (result) in
            switch result {
            case .success(let gameTrailer):
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.gameTrailer = gameTrailer
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
