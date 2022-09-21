//
//  TabBarView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import SwiftUI

struct TabBarView: View {
    @State var tabSelection: Tabs = .home
    @AppStorage("darkModeEnabled") private var darkModeEnabled: Bool = Theme.isNotDarkMode
    let helper: Helper
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                HomeView(viewModel: HomeViewModel(services: APIServices(constant: Constants())))
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Movie")
                    }
                    .tag(Tabs.home)
                ProfileView(viewModel: ProfileViewModel(constant: Constants()))
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
                    .tag(Tabs.favorite)
                SettingsView(darkModeEnabled: $darkModeEnabled, viewModel: SettingsViewModel(constant: Constants()))
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .tag(Tabs.settings)
            }
            .navigationBarTitle(helper.returnNavBarTitle(tabSelection: self.tabSelection))
            .onAppear {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
        .accentColor(.primary)
        .navigationViewStyle(.stack)
    }
}
