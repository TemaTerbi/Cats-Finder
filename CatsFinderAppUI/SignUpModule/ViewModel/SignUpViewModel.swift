//
//  SignUpViewModel.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 07.10.2022.
//

import Combine
import Firebase
import FirebaseAuth

final class SignUpViewModel: ObservableObject {
    
    @Published private(set) var error: Bool = false
    
    func signUp(_ email: String, _ password: String, _ name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                if let result = result {
                    let refDataBase = Database.database().reference().child("Users")
                    refDataBase.child(result.user.uid).updateChildValues(["Name" : name, "Email": email])
                    
                    var userId = Auth.auth().currentUser?.uid ?? ""
                    UserDefaults.standard.set(userId, forKey: "userId")
                    
                    UserDefaults.standard.set(true, forKey: "status")
                    
                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                }
            } else if error?.localizedDescription == FirebaseError.emailAlreadyInUse.error {
                self.error = true
            }
        }
    }
    
}
