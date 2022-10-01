//
//  Helper.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

struct Helper {
    func returnNavBarTitle(tabSelection: Tabs) -> String {
        switch tabSelection {
        case .home: return "Home"
        case .search: return "Search"
        case .favorite: return "Favorite"
        case .profile: return "Profile"
        case .settings: return "Settings"
        }
    }
    func getGenres(genres: [GameGenre]) -> String {
        var arrayGenre: [String] = []
        for genre in genres {
            arrayGenre.append(genre.name)
        }
        return arrayGenre.joined(separator: ", ")
    }
    func getDetailGenres(genres: [GameDetailGenre]) -> String {
        var arrayGenre: [String] = []
        for genre in genres {
            arrayGenre.append(genre.name)
        }
        return arrayGenre.joined(separator: ", ")
    }
    func handleStringNoValue(data: String) -> String {
        var result: String = ""
        if data == "" || data == " " {
            result = " - "
        } else {
            result = data
        }
        return result
    }
}
