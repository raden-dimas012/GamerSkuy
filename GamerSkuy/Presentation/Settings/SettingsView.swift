//
//  SettingsView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var darkModeEnabled: Bool
    @EnvironmentObject var viewModel: SettingsViewModel
    var body: some View {
        Form {
            Section(header: Text(viewModel.constant?.darkModeTitle ?? ""),
                    footer: Text(viewModel.constant?.darkModeDescription ?? "")) {
                Toggle(isOn: $darkModeEnabled, label: {
                    Image(systemName: viewModel.constant?.darkModeImage ?? "")
                    Text(viewModel.constant?.darkModeTitle ?? "")
                }).onChange(of: darkModeEnabled, perform: { _ in
                    viewModel.switchToDarkMode()
                })
            }
        }
    }
}
