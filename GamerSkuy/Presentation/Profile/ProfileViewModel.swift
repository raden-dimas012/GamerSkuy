//
//  ProfileViewModel.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 13/09/22.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var textName: String = ""
    @Published var textBirth: Date = Date()
    @Published var textEmail: String = ""
    @Published var textRole: String = ""
    @Published var showDatePicker: Bool = false
    @Published var showAlertSaveData: Bool = false
    @Published var showAlertValidateTexfield: Bool = false
    @Published var profile: Profile?
    var constant: Constants?
    private var name: String {
        get {
            guard let constant = constant else {return ""}
            return UserDefaults.standard.string(forKey: "name") ?? constant.myName
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "name")
        }
    }
    private var birth: String {
        get {
            guard let constant = constant else {return ""}
            return UserDefaults.standard.string(forKey: "birth") ?? constant.myBirth
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "birth")
        }
    }
    private var email: String {
        get {
            guard let constant = constant else {return ""}
            return UserDefaults.standard.string(forKey: "email") ?? constant.myEmail
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "email")
        }
    }
    private var role: String {
        get {
            guard let constant = constant else {return ""}
            return UserDefaults.standard.string(forKey: "role") ?? constant.myRole
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "role")
        }
    }
    init(constant: Constants) {
        self.constant = constant
    }
    deinit {
        self.constant = nil
        debugPrint("Deinit ProfileViewModel")
    }
    func saveDataProfile(
        name: String,
        birth: String,
        email: String,
        role: String
    ) {
        self.name = name
        self.birth = birth
        self.email = email
        self.role = role
        getDataFromUserDefaults()
    }
    func getDataFromUserDefaults() {
        guard let constant = constant else {return}
        DispatchQueue.main.async {
            self.profile = Profile(
                name: self.name,
                birth: self.birth,
                email: self.email,
                role: self.role,
                image: constant.myPhoto)
            self.textBirth = self.birth.stringToDate()
        }
    }
    func validateEmail(email: String) -> Bool {
        let emailValidationRegex = """
        ^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\
        p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+
        (?:\\.[\\p{L}0-9-]{2,7})*$
        """
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}
