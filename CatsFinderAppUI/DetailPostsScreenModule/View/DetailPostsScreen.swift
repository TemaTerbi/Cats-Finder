//
//  DetailPostsScreen.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 10.11.2022.
//

import SwiftUI
import Firebase

struct DetailPostsScreen: View {
    let posts: Posts
    @State private var goNext: Bool = false
    @State private var delete: Bool = false
    @State private var currentUserId = UserDefaults.standard.string(forKey: "userId")
    @ObservedObject var viewModel = DetailPostsViewModel()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        if goNext {
            VStack(alignment: .leading) {
                URLImage(urlString: "https://koshek.ru/images/big-images/1_soderzhanie/obshie-voprosy/interesnye-fakty-o-koshkah/interesnye-fakty-o-koshkah.jpg")
                    .cornerRadius(25)
                    .frame(height: 200)
                    .padding(.horizontal, 10)
                    .padding(.top, 150)
                Spacer()
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack(spacing: 15) {
                        Image(systemName: "text.bubble.fill")
                            .foregroundColor(.indigo)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        Text(posts.title)
                            .fontWeight(.bold)
                            .font(.system(size: 30, design: .rounded))
                            .fontWeight(.bold)
                    }
                    HStack(spacing: 15) {
                        Image(systemName: "pawprint.fill")
                            .foregroundColor(.indigo)
                        Text("Порода: \(posts.cat.breed)")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        
                    }
                    
                    HStack(spacing: 15) {
                        Image(systemName: "location.fill")
                            .foregroundColor(.indigo)
                        Text(posts.place)
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                    }
                    
                    HStack(spacing: 15) {
                        Image(systemName: "calendar.circle.fill")
                            .foregroundColor(.indigo)
                        Text(posts.date)
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                    }
                    
                    HStack(spacing: 15) {
                        Image(systemName: "text.justify.left")
                            .foregroundColor(.indigo)
                        Text(posts.description)
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            .lineLimit(0)
                    }
                    Spacer()
                    
                    if currentUserId == posts.userOwnId {
                        HStack(alignment: .center) {
                            Button {
                                viewModel.deletePost(posts.id)
                                mode.wrappedValue.dismiss()
                            } label: {
                                Text("Удалить")
                                    .font(.system(size: 15))
                                    .padding(15)
                            }
                            .frame(height: 45)
                            .background(Color.red)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                            
                            Button {
                                
                            } label: {
                                Text("Редактировать")
                                    .font(.system(size: 15))
                                    .padding(15)
                            }
                            .frame(height: 45)
                            .background(Color.indigo)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 20)
                .padding(.bottom, 150)
                .padding(.top, 30)
                .animation(.spring())
                
                Spacer()
            }
            .background(.gray.opacity(0.1)).edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.left")
                    .foregroundColor(.indigo)
                Text("Назад")
                    .foregroundColor(.indigo)
            })
        } else {
            VStack {
                LoaderImage(animationName: "loaderCat", loopMode: .loop)
                    .frame(width: 100, height: 100)
                Text("Мяу...")
                    .font(.system(size: 20, design: .rounded))
                    .foregroundColor(.indigo)
                    .padding(10)
            }
            .task {
                await delay()
            }
            .navigationBarBackButtonHidden(true)
            .animation(.easeInOut)
        }
    }
    
    private func delay() async {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        goNext = true
    }
}
