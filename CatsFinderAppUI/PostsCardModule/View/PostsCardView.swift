//
//  PostsCardView.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 12.10.2022.
//

import SwiftUI

struct PostsCardView: View {
    let posts: Posts
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white)
                .frame(height: 350)
                .overlay {
                    VStack {
                        VStack(alignment: .leading) {
                            URLImage(urlString: "https://koshek.ru/images/big-images/1_soderzhanie/obshie-voprosy/interesnye-fakty-o-koshkah/interesnye-fakty-o-koshkah.jpg")
                                .frame(height: 200)
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(spacing: 15) {
                                    Image(systemName: "text.bubble.fill")
                                    Text(posts.title)
                                        .fontWeight(.bold)
                                        .font(.system(size: 20, design: .rounded))
                                }
                                HStack(spacing: 15) {
                                    Image(systemName: "pawprint.fill")
                                    Text("Порода: \(posts.cat.breed)")
                                        .fontWeight(.bold)
                                        .font(.system(size: 16))
                                }
                                HStack(spacing: 15) {
                                    Image(systemName: "location.fill")
                                    Text(posts.place)
                                        .fontWeight(.bold)
                                        .font(.system(size: 16))
                                }
                                HStack(spacing: 15) {
                                    Image(systemName: "calendar.circle.fill")
                                    Text(posts.date)
                                        .fontWeight(.bold)
                                        .font(.system(size: 16))
                                }
                            }
                            .padding(.top, 20)
                            .padding(.leading, 15)
                            .padding(.bottom, 35)
                            
                            Spacer()
                        }
                    }
                }
        }
        .cornerRadius(30)
    }
}

