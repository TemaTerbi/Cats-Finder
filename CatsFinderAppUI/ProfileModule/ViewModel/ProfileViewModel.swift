//
//  ProfileViewModel.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 12.10.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var userName = ""
    @Published var posts: [Posts] = []
    @Published var backGroundMet = false
    private var refDataBase = Database.database().reference()
    
    private var db = Firestore.firestore()
    
    func signOut() {
        do {
            try? Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "status")
            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
        } catch {
            print(error)
        }
    }
    
    func getDataUser() {
        let userId = Auth.auth().currentUser?.uid ?? ""
        refDataBase.child("Users").child(userId).observeSingleEvent(of: .value) {snap, string    in
            let value = snap.value as? NSDictionary
            let userName = value?["Name"] as? String ?? ""
            self.userName = userName
        }
    }
    
    func getPosts() {
        ApiManager.shared.getAllPosts { posts in
            let userId = Auth.auth().currentUser?.uid ?? ""
            for post in posts {
                let checkOnUniquePost = posts.contains { postt in
                    postt.id != post.id
                }
                if post.userOwnId == userId && checkOnUniquePost {
                    self.posts.append(post)
                } else {
                   print("Не ваш пост")
                }
            }
            self.backGroundMet = true
        }
    }
}
