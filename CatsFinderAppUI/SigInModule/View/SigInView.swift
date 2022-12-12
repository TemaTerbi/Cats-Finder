//
//  SigInView.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 06.10.2022.
//

import SwiftUI

struct SigInView: View {
    
    @State private var userEmail = ""
    @State private var userPassword = ""
    @State private var emailCheck = ""
    @State private var emailTextFieldValid = false
    @State private var passwordTextFieldValid = false
    @State private var allValid = true
    
    @ObservedObject var viewModel: SigInViewModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    private func chechkTextInTextField() {
        if userEmail.count > 2 {
            emailCheck = "person.crop.circle.fill.badge.checkmark"
        }
    }
    
    private func onButton(_ emailValid: Bool, _ passwordValid: Bool) -> Bool {
        if emailValid && passwordValid {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            VStack {
                Text("Вход")
                    .font(.system(size: 30))
                VStack(alignment: .center) {
                    if viewModel.noUser {
                        LoaderImage(animationName: "noUser", loopMode: .loop)
                            .frame(width: 150, height: 150)
                            .animation(.spring())
                        Text("Мяу! Наши котики не нашли такого пользователя...")
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .animation(.spring())
                    } else if viewModel.wrongPass {
                        LoaderImage(animationName: "wrongPass", loopMode: .loop)
                            .frame(width: 150, height: 150)
                            .animation(.spring())
                        Text("Мяу! Ты ошибся, пароль неверный...")
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .animation(.spring())
                    } else {
                        LoaderImage(animationName: "sigInView", loopMode: .loop)
                            .frame(width: 150, height: 150)
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                ZStack(alignment: .trailing) {
                    
                    if userEmail.contains("@") && userEmail.contains(".com") || userEmail.contains(".ru")  {
                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
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
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.2)
                        )
                        .onChange(of: userEmail) { newValue in
                            self.emailTextFieldValid = self.checkTextFieldValidationEmail(userEmail)
                            self.allValid = self.onButton(emailTextFieldValid, passwordTextFieldValid)
                        }
                }
                
                
                SecureField("Пароль", text: $userPassword)
                    .frame(width: 320, height: 55)
                    .multilineTextAlignment(.center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                            .opacity(0.2)
                    )
                    .textContentType(.password)
                    .onChange(of: userPassword) { newValue in
                        self.passwordTextFieldValid = self.checkTextFieldValidationPassword(userPassword)
                        self.allValid = self.onButton(emailTextFieldValid, passwordTextFieldValid)
                    }
            }
            
            Spacer()
            
            VStack{
                Button {
                    viewModel.sigIn(userEmail, userPassword)
                } label: {
                    Text("Войти")
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
                    Text("Еще нет аккаунта?")
                        .font(.system(size: 14))
                    NavigationLink {
                        SignUpView(viewModel: SignUpViewModel.init())
                    } label: {
                        Text("Зарегистрируйтесь")
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

struct SigInView_Previews: PreviewProvider {
    static var previews: some View {
        SigInView(viewModel: SigInViewModel.init())
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func checkTextFieldValidationEmail(_ text: String) -> Bool {
        if text.contains("@") && text.contains(".com") || text.contains(".ru") {
            return true
        } else {
            return false
        }
    }
    
    func checkTextFieldValidationName(_ text: String) -> Bool {
        if text.count >= 3 {
            return true
        } else {
            return false
        }
    }
    
    func checkTextFieldValidationPassword(_ text: String) -> Bool {
        if text.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
    func checkTextFieldValidationPasswordReType(_ password: String, _ retypePassword: String) -> Bool {
        if password.count >= 6 && retypePassword.count >= 6 {
            if password == retypePassword {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
#endif
