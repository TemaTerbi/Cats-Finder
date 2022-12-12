//
//  ProfileHeaderView.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 12.10.2022.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @ObservedObject var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color.indigo)
                .frame(height: 350)
                .overlay {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.white)
                            .clipped()
                        
                        Text(viewModel.userName)
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            //
                        } label: {
                            Text("Редактировать")
                                .font(.system(size: 15))
                        }
                        .frame(width: 170, height: 45)
                        .background(Color.white)
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
                    .padding(35)
                }
        }
        .background(Color.indigo.edgesIgnoringSafeArea(.all))
        .onAppear() {
            viewModel.getDataUser()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(viewModel: ProfileViewModel.init())
    }
}
