//
//  AddPostsViewModel.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 16.11.2022.
//

import Foundation

final class AddPostsViewModel: ObservableObject {
    
    func addPosts(_ parametrs:[String: Any]) {
        ApiManager.shared.addPost(parametrs)
    }
}
