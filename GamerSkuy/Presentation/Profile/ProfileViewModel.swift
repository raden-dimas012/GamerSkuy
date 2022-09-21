//
//  ProfileViewModel.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 13/09/22.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    let profile: Profile
    var constant: Constants?
    init(constant: Constants) {
        self.constant = constant
        self.profile = .init(name: constant.myName, birth: constant.myBirth,
                             email: constant.myEmail, role: constant.myRole, image: constant.myPhoto)
    }
    deinit {
        self.constant = nil
    }
}
