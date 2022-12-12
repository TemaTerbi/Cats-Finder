//
//  MainPostPageViewModel.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 11.11.2022.
//

import Foundation

final class MainPostPageViewModel: ObservableObject {
    
    @Published var posts: [Posts] = []
    @Published var backGroundMet: Bool = false
    
    func getPosts() {
        ApiManager.shared.getAllPosts { posts in
            self.posts = posts
            self.backGroundMet = true
        }
    }
    
}
