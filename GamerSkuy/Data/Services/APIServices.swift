//
//  APIServices.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import Foundation

protocol APIServicesProtocol {
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
    func getGames(genreID: Int, page: Int, completion: @escaping (Result<[Game], Error>) -> Void)
    func getGameDetail(movieID: Int, completion: @escaping (Result<GameDetail, Error>) -> Void)
    func getTrailer(movieID: Int, completion: @escaping (Result<[Trailer], Error>) -> Void)
}

final class APIServices: APIServicesProtocol {
    var constant: Constants?
    init(constant: Constants) {
        self.constant = constant
    }
    deinit {
        self.constant = nil
    }
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        guard let constant = constant else {return}
        guard let url = URL(string: constant.baseURL + "genres?" + constant.apiKey) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(ResponsesGenre.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    func getGames(genreID: Int, page: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
        guard let constant = constant else { return }
        guard let url = URL(string: constant.baseURL + "games?" + constant.apiKey + "&page=\(page)"
                            + "&genres=\(genreID)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(ResponsesGame.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    func getGameDetail(movieID: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
        guard let constant = constant else {return}
        guard let url = URL(string: constant.detailBaseURL + "/\(movieID)?" + constant.apiKey) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let results = try JSONDecoder().decode(ResponsesGameDetail.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    func getTrailer(movieID: Int, completion: @escaping (Result<[Trailer], Error>) -> Void) {
        guard let constant = constant else {return}
        guard let url = URL(string: constant.detailBaseURL + "/\(movieID)/movies?" + constant.apiKey) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(ResponsesTrailer.self, from: data)
                completion(.success(results.results))
                debugPrint(results.results)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
