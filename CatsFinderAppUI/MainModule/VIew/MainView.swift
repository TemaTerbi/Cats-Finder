//
//  MainView.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 06.10.2022.
//

import SwiftUI
import AVKit

struct MainView: View {
    
    @ObservedObject var viewModel: SigInViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center, spacing: 0) {
                    Text("CATS FINDER")
                        .font(Font.largeTitle)
                        .bold()
                    Text("Найди, отдай, приюти")
                        .font(.system(size: 18))
                }
                .overlay(content: {
                    LoaderImage(animationName: "mainCat", loopMode: .loop)
                        .frame(width: 200, height: 200)
                        .padding(.bottom, 110)
                })
                .padding(.top, 230)
                
                Spacer()
                
                VStack(alignment: .center) {
                    NavigationLink {
                        SigInView(viewModel: SigInViewModel.init())
                    } label: {
                        Text("Войти")
                        .frame(width: 320, height: 55)
                        .foregroundColor(Color.white)
                        .background(Color.indigo)
                        .cornerRadius(20)
                        .buttonStyle(.automatic)
                    }
                    
                    NavigationLink {
                        SignUpView(viewModel: SignUpViewModel.init())
                    } label: {
                        Text("Зарегистрироваться")
                        .frame(width: 320, height: 55)
                        .foregroundColor(Color.white)
                        .background(Color.orange)
                        .cornerRadius(20)
                        .buttonStyle(.automatic)
                    }
                }
                .padding(.bottom, 5)
            } .onAppear() {
                viewModel.falseUser()
                viewModel.falsePass()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: SigInViewModel.init())
    }
}
