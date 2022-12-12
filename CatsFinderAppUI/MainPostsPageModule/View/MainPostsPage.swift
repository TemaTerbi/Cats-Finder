//
//  MainPostsPage.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 11.11.2022.
//

import SwiftUI

struct MainPostsPage: View {
    
    @ObservedObject var viewModel = MainPostPageViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.posts.isEmpty {
                    VStack {
                        LoaderImage(animationName: "loaderCat", loopMode: .loop)
                            .frame(width: 100, height: 100)
                    }
                    .background(.clear).edgesIgnoringSafeArea(.all)
                } else {
                    VStack {
                        VStack {
                            HStack {
                                Text("Все посты")
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                NavigationLink(destination: AddPostsView()) {
                                    Image(systemName: "plus.app")
                                        .foregroundColor(.indigo)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 25)
                        .padding(.top, 60)
                        .background(.white)
                        ScrollView {
                            ForEach((viewModel.posts.reversed()), id: \.self) { posts in
                                NavigationLink(destination: DetailPostsScreen(posts: posts)) {
                                    PostsCardView(posts: posts)
                                        .padding(.top, 10)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                        .   padding(.bottom, 90)
                    }
                }
            }
            .background(viewModel.backGroundMet ? .gray.opacity(0.1) : .clear).edgesIgnoringSafeArea(.all)
            .onAppear() {
                viewModel.getPosts()
            }
        }
    }
}

struct MainPostsPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPostsPage()
    }
}
