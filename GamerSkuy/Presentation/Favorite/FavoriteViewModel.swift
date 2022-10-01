//
//  FavoriteViewModel.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 23/09/22.
//

import CoreData

final class FavoriteViewModel: ObservableObject {
    @Published var favoriteGame = [GameFavorite]()
    @Published var isFavorite: Bool = false
    var helper: Helper?
    init(helper: Helper) {
        self.helper = helper
    }
    deinit {
        self.helper = nil
        debugPrint("Deinit FavoriteViewModel")
    }
    func checkIsFavorite(id: Int) {
        isFavorite = favoriteGame.contains(where: {$0.id == id })
    }
    func addFavorite(context: NSManagedObjectContext, data: GameDetail) {
        context.perform {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: context) {
                let game = NSManagedObject(entity: entity, insertInto: context)
                game.setValue(data.id, forKey: "id")
                game.setValue(data.name, forKey: "name")
                game.setValue(data.backgroundImage, forKey: "backgroundImage")
                game.setValue(data.rating, forKey: "rating")
                game.setValue(data.released, forKey: "released")
                guard let helper = self.helper else {return}
                game.setValue(helper.getDetailGenres(genres: data.genres), forKey: "genres")
                do {
                    try context.save()
                    self.getDataFromCoreData(context: context)
                    debugPrint("Succeed add data to CoreData.")
                } catch let error as NSError {
                    debugPrint("Failed Save to CoreData \(error.localizedDescription)")
                }
            }
        }
    }
    func getDataFromCoreData(context: NSManagedObjectContext) {
        context.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
            do {
                let results = try context.fetch(fetchRequest)
                var games = [GameFavorite]()
                for result in results {
                    let game = GameFavorite(
                        id: result.value(forKeyPath: "id") as? Int,
                        name: result.value(forKeyPath: "name") as? String,
                        backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
                        released: result.value(forKeyPath: "released") as? String,
                        rating: result.value(forKeyPath: "rating") as? Double,
                        genres: result.value(forKeyPath: "genres") as? String
                    )
                    games.append(game)
                }
                self.favoriteGame.removeAll()
                self.favoriteGame.append(contentsOf: games)
            } catch let error as NSError {
                debugPrint("Failed Get Data From Core Data \(error.localizedDescription)")
            }
        }
    }
    func removeFromFavorite(context: NSManagedObjectContext, id: Int) {
        context.perform {
            let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                let gameFav = try context.fetch(fetchRequest)
                if let game = gameFav.first {
                    context.delete(game)
                }
                try context.save()
            } catch let error as NSError {
                debugPrint("Error Deleting Data...\(error.localizedDescription)")
            }
            self.getDataFromCoreData(context: context)
        }
    }
}
