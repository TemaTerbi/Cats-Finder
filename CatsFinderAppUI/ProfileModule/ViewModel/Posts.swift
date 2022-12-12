//
//  Posts.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 09.11.2022.
//

import SwiftUI

struct Posts: Codable, Hashable {
    var id: String
    var title: String
    var description: String
    var place: String
    var cat: Cat
    var date: String
    var userOwnId: String
}

struct Cat: Codable, Hashable {
    var breed: String
    var color: String
}
