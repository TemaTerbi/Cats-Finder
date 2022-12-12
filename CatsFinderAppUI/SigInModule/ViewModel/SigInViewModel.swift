//
//  SigInViewModel.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 07.10.2022.
//

import Combine
import Foundation
import Firebase
 

enum FirebaseError {
    case noUser
    case wrongPasswordLong
    case wrongEmail
    case wrongPassword
    case emailAlreadyInUse
    
    var error: String {
        switch self {
        case .noUser:
            return "There is no user record corresponding to this identifier. The user may have been deleted."
        case .wrongPasswordLong:
            return "The password must be 6 characters long or more."
        case .wrongEmail:
            return "The email address is badly formatted."
        case .wrongPassword:
            return "The password is invalid or the user does not have a password."
        case .emailAlreadyInUse:
            return "The email address is already in use by another account."
        }
    }
}

final class SigInViewModel: ObservableObject {
    
    @Published private(set) var noUser = false
    @Published private(set) var wrongPass = false
    
    func sigIn(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error?.localizedDescription == FirebaseError.noUser.error {
                self.noUser = true
            } else if error?.localizedDescription == FirebaseError.wrongPassword.error {
                self.wrongPass = true
            } else if error == nil {
                var userId = Auth.auth().currentUser?.uid ?? ""
                UserDefaults.standard.set(userId, forKey: "userId")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            }
        }
    }
    
    func falseUser() {
        self.noUser = false
    }
    
    func falsePass() {
        self.wrongPass = false
    }
    
}
