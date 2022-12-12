//
//  DetailPostsViewModel.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 25.11.2022.
//

import Foundation

final class DetailPostsViewModel: ObservableObject {
    func deletePost(_ id: String) {
        ApiManager.shared.delPost(id)
    }
}
