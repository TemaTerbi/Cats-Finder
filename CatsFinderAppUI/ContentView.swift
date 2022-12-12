//
//  ContentView.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 06.10.2022.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State private var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        VStack {
            if status {
                TabView {
                    MainPostsPage()
                        .transition(AnyTransition.slide.animation(.spring()))
                        .tabItem {
                            Image(systemName: "doc.richtext")
                            Text("Посты")
                        }
                        .background(.white)
                    
                    ProfileView()
                        .transition(AnyTransition.slide.animation(.spring()))
                        .tabItem {
                            Image(systemName: "person.text.rectangle")
                            Text("Профиль")
                        }
                        .background(.white)
                }
                .background(.white)
                .animation(.spring())
            } else {
                MainView(viewModel: SigInViewModel.init())
                    .transition(AnyTransition.slide.animation(.spring()))
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                
                self.status = status
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

