//
//  GamerSkuyApp.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 09/09/22.
//

import SwiftUI

@main
struct GamerSkuyApp: App {
    @AppStorage("darkModeEnabled") private var darkModeEnabled: Bool = Theme.isNotDarkMode
    var body: some Scene {
        WindowGroup {
            TabBarView(helper: Helper())
                .preferredColorScheme(darkModeEnabled ? .dark : .light)
        }
    }
}
