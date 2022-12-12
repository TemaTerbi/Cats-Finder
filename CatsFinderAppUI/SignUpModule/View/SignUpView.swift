//
//  SignUpView.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 07.10.2022.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var userName = ""
    @State private var userEmail = ""
    @State private var userPassword = ""
    @State private var userRetypePassword = ""
    @State private var emailCheck = ""
    @State private var userNameTextFieldValid = false
    @State private var emailTextFieldValid = false
    @State private var passwordTextFieldValid = false
    @State private var passwordReTypeTextFieldValid = false
    @State private var allValid = true
    
    @ObservedObject var viewModel: SignUpViewModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    private func onButton(_ emailValid: Bool, _ passwordValid: Bool, _ passwordReType: Bool, _ name: Bool) -> Bool {
        if emailValid && passwordValid && passwordReType && name  {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            VStack {
                Text("Регистрация")
                    .font(.system(size: 30))
                LoaderImage(animationName: "playCat", loopMode: .loop)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                ZStack(alignment: .trailing) {
                    
                    if userName.count >= 3 {
                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
                            .padding(10)
                            .foregroundColor(Color.green)
                    } else {
                        Image(systemName: "")
                    }
                    
                    TextField("Ваше имя", text: $userName)
                        .frame(width: 320, height: 55)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(userNameTextFieldValid ? Color.orange : Color.black, lineWidth: 1)
                                .opacity(userNameTextFieldValid ? 1 : 0.2)
                        )
                        .animation(.spring())
                        .onChange(of: userName) { newValue in
                            self.userNameTextFieldValid = self.checkTextFieldValidationName(userName)
                            self.allValid = self.onButton(emailTextFieldValid, passwordTextFieldValid, passwordReTypeTextFieldValid, userNameTextFieldValid)
                        }
                }
                
                ZStack(alignment: .trailing) {
                    
                    if userEmail.contains("@") && userEmail.contains(".com") || userEmail.contains(".ru") {
                        Image(systemName: "checkmark")
                            .padding(10)
                            .foregroundColor(Color.green)
                    } else {
                        Image(systemName: "")
                    }
                    
                    TextField("Почта", text: $userEmail)
                        .frame(width: 320, height: 55)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(emailTextFieldValid ? Color.orange : Color.black, lineWidth: 1)
                                .opacity(emailTextFieldValid ? 1 : 0.2)
                        )
                        .animation(.spring())
                        .onChange(of: userEmail) { newValue in
                            self.emailTextFieldValid = self.checkTextFieldValidationEmail(userEmail)
                            self.allValid = self.onButton(emailTextFieldValid, passwordTextFieldValid, passwordReTypeTextFieldValid, userNameTextFieldValid)
                        }
                }
                
                ZStack(alignment: .trailing) {
                    
                    if userPassword.count >= 6 {
                        Image(systemName: "checkmark")
                            .padding(10)
                            .foregroundColor(Color.green)
                    } else {
                        Image(systemName: "")
                    }
                    
                    SecureField("Пароль", text: $userPassword)
                        .frame(width: 320, height: 55)
                        .multilineTextAlignment(.center)
                        .textContentType(.newPassword)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(passwordTextFieldValid ? Color.orange : Color.black, lineWidth: 1)
                                .opacity(passwordTextFieldValid ? 1 : 0.2)
                        )
                        .animation(.spring())
                        .onChange(of: userPassword) { newValue in
                            self.passwordTextFieldValid = self.checkTextFieldValidationPassword(userPassword)
                            self.allValid = self.onButton(emailTextFieldValid, passwordTextFieldValid, passwordReTypeTextFieldValid, userNameTextFieldValid)
                        }
                }
                
                ZStack(alignment: .trailing) {
                    
                    if userPassword.count >= 6 && userRetypePassword.count >= 6 {
                        if userPassword == userRetypePassword {
                            Image(systemName: "checkmark")
                                .padding(10)
                                .foregroundColor(Color.green)
                        } else {
                            Image(systemName: "xmark.octagon.fill")
                                .padding(10)
                                .foregroundColor(Color.red)
                        }
                    } else {
                        Image(systemName: "")
                    }
                    
                    SecureField("Повторите пароль", text: $userRetypePassword)
                        .frame(width: 320, height: 55)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(passwordReTypeTextFieldValid ? Color.orange : Color.black, lineWidth: 1)
                                .opacity(passwordReTypeTextFieldValid ? 1 : 0.2)
                        )
                        .animation(.spring())
                        .textContentType(.password)
                        .onChange(of: userRetypePassword) { newValue in
                            self.passwordReTypeTextFieldValid = self.checkTextFieldValidationPasswordReType(userPassword, userRetypePassword)
                            self.allValid = self.onButton(emailTextFieldValid, passwordTextFieldValid, passwordReTypeTextFieldValid, userNameTextFieldValid)
                        }
                }
            }
            
            Spacer()
            
            VStack{
                Button("Зарегистрироваться") {
                    viewModel.signUp(userEmail, userPassword, userName)
                }
                .frame(width: 320, height: 55)
                .foregroundColor(Color.white)
                .background(allValid ? Color.indigo : Color.orange)
                .opacity(allValid ? 0.5 : 1)
                .cornerRadius(20)
                .buttonStyle(.automatic)
                .disabled(allValid)
                .animation(.spring())
                
                HStack {
                    Text("У вас уже есть Аккаунт?")
                        .font(.system(size: 14))
                    NavigationLink {
                        SigInView(viewModel: SigInViewModel.init())
                    } label: {
                        Text("Войти")
                            .font(.system(size: 14))
                            .foregroundColor(Color.orange)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "chevron.left")
                .foregroundColor(.indigo)
            Text("Назад")
                .foregroundColor(.indigo)
        })
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel.init())
    }
}
