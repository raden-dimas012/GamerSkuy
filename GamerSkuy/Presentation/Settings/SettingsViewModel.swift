//
//  SettingsViewModel.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 12/09/22.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    @AppStorage("darkModeEnabled") private var darkModeEnabled: Bool = false
    var constant: Constants?
    init(constant: Constants) {
        self.constant = constant
    }
    deinit {
        self.constant = nil
    }
    func switchToDarkMode() {
        darkModeEnabled.toggle()
    }
}
