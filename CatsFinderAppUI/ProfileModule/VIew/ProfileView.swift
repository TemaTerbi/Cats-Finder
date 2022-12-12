//
//  ProfileView.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 07.10.2022.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Spacer()
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.indigo)
                        
                        Text(viewModel.userName)
                            .foregroundColor(Color.indigo)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                        
                        Button {
                            //
                        } label: {
                            Text("Редактировать")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                        }
                        .frame(width: 170, height: 45)
                        .background(Color.indigo)
                        .foregroundColor(Color.black)
                        .cornerRadius(25)
                        
                        Button {
                            viewModel.signOut()
                        } label: {
                            Text("Выйти")
                                .font(.system(size: 15))
                        }
                        .frame(width: 170, height: 45)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(25)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 400)
                
                Spacer()
                
                VStack {
                    if viewModel.posts.isEmpty {
                        ScrollView {
                            LoaderImage(animationName: "loaderCat", loopMode: .loop)
                                .frame(width: 100, height: 100)
                        }
                    } else {
                        ScrollView {
                            ForEach((viewModel.posts), id: \.self) { posts in
                                NavigationLink(destination: DetailPostsScreen(posts: posts)) {
                                    PostsCardView(posts: posts)
                                        .padding(.top, 10)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .padding(20)
                        .padding(.bottom, 80)
                    }
                }
                .background(viewModel.backGroundMet ? .gray.opacity(0.1) : .clear).edgesIgnoringSafeArea(.all)
            }
            .onAppear() {
                viewModel.getDataUser()
                viewModel.getPosts()
        }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel.init())
    }
}
