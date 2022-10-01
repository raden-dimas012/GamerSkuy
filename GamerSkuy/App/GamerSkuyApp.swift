//
//  GamerSkuyApp.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 09/09/22.
//

import SwiftUI
import CoreData

@main
struct GamerSkuyApp: App {
    @AppStorage("darkModeEnabled") private var darkModeEnabled: Bool = Theme.isNotDarkMode
    let coreDataManager = CoreDataManager.shared
    var body: some Scene {
        WindowGroup {
            TabBarView(helper: Helper())
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
                .preferredColorScheme(darkModeEnabled ? .dark : .light)
                .environmentObject(HomeViewModel(services: APIServices(constant: Constants())))
                .environmentObject(SearchViewModel(services: APIServices(constant: Constants())))
                .environmentObject(FavoriteViewModel(helper: Helper()))
                .environmentObject(SettingsViewModel(constant: Constants()))
                .environmentObject(ProfileViewModel(constant: Constants()))
        }
    }
}
