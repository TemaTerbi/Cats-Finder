//
//  CatsFinderAppUIApp.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 06.10.2022.
//

import SwiftUI
import FirebaseCore

@main
struct CatsFinderAppUIApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
