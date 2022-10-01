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
                HomeView()
                    .tabItem {
                        Label {
                            Text("Home")
                        } icon: {
                            Image(systemName: "house.fill")
                        }
                    }
                    .tag(Tabs.home)
                SearchView()
                    .tabItem {
                        Label {
                            Text("Search")
                        } icon: {
                            Image(systemName: "magnifyingglass.circle")
                        }
                    }
                    .tag(Tabs.search)
                FavoriteView()
                    .tabItem {
                        Label {
                            Text("Favorite")
                        } icon: {
                            Image(systemName: "heart.circle")
                        }
                    }
                    .tag(Tabs.favorite)
                ProfileView()
                    .tabItem {
                        Label {
                            Text("Profile")
                        } icon: {
                            Image(systemName: "person.circle.fill")
                        }
                    }
                    .tag(Tabs.profile)
                SettingsView(darkModeEnabled: $darkModeEnabled)
                    .tabItem {
                        Label {
                            Text("Settings")
                        } icon: {
                            Image(systemName: "gearshape")
                        }
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
