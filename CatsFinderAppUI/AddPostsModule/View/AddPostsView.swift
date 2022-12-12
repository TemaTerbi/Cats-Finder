//
//  AddPostsView.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 16.11.2022.
//

import SwiftUI

struct AddPostsView: View {
    
    @State private var title = ""
    @State private var titleValid = false
    @State private var description = ""
    @State private var descriptionValid = false
    @State private var place = ""
    @State private var placeValid = false
    @State private var phone = ""
    @State private var phoneValid = false
    @State private var date = ""
    @State private var dateValid = false
    @State private var breed = ""
    @State private var breedValid = false
    @State private var color = ""
    @State private var colorValid = false
    @State private var allValid = true
    @State private var needReload = false
    @State private var goNext: Bool? = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var viewModel = AddPostsViewModel()
    
    private func onButton(_ titleValid: Bool, _ descriptionValid: Bool, _ placeValid: Bool, _ phoneValid: Bool, _ dateValid: Bool, _ breedValid: Bool, _ colorValid: Bool) -> Bool {
        if titleValid && descriptionValid && placeValid && phoneValid && dateValid && breedValid && colorValid {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        if needReload {
            VStack {
                LoaderImage(animationName: "loaderCat", loopMode: .loop)
                    .frame(width: 100, height: 100)
            }
            .background(.clear).edgesIgnoringSafeArea(.all)
            .task {
                await delay()
            }
            .navigationBarBackButtonHidden(true)
            .animation(.easeInOut)
        } else {
            ScrollView(showsIndicators: false) {
                VStack {
                    if allValid {
                        LoaderImage(animationName:"sleepCat", loopMode: .loop)
                            .frame(width: 200, height: 200)
                            .animation(.spring())
                    } else {
                        LoaderImage(animationName:"strCat", loopMode: .loop)
                            .frame(width: 200, height: 200)
                            .animation(.spring())
                    }
                    VStack(spacing: 20) {
                        TextField("Заголовок", text: $title)
                            .frame(width: 320, height: 55)
                            .multilineTextAlignment(.center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(titleValid ? Color.orange : Color.black, lineWidth: 1)
                                    .opacity(titleValid ? 1 : 0.2)
                            )
                            .animation(.spring())
                            .onChange(of: title) { newValue in
                                self.titleValid = self.checkTextFieldValidationName(title)
                                self.allValid = self.onButton(titleValid, descriptionValid, placeValid, phoneValid, dateValid, breedValid, colorValid)
                            }
                        
                        TextField("Описание", text: $description)
                            .frame(width: 320, height: 150)
                            .multilineTextAlignment(.center)
                            .lineLimit(0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(descriptionValid ? Color.orange : Color.black, lineWidth: 1)
                                    .opacity(descriptionValid ? 1 : 0.2)
                            )
                            .animation(.spring())
                            .onChange(of: description) { newValue in
                                self.descriptionValid = self.checkTextFieldValidationName(description)
                                self.allValid = self.onButton(titleValid, descriptionValid, placeValid, phoneValid, dateValid, breedValid, colorValid)
                            }
                        
                        TextField("Порода", text: $breed)
                            .frame(width: 320, height: 55)
                            .multilineTextAlignment(.center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(breedValid ? Color.orange : Color.black, lineWidth: 1)
                                    .opacity(breedValid ? 1 : 0.2)
                            )
                            .animation(.spring())
                            .onChange(of: breed) { newValue in
                                self.breedValid = self.checkTextFieldValidationName(breed)
                                self.allValid = self.onButton(titleValid, descriptionValid, placeValid, phoneValid, dateValid, breedValid, colorValid)
                            }
                        
                        TextField("Цвет кота", text: $color)
                            .frame(width: 320, height: 55)
                            .multilineTextAlignment(.center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(colorValid ? Color.orange : Color.black, lineWidth: 1)
                                    .opacity(colorValid ? 1 : 0.2)
                            )
                            .animation(.spring())
                            .onChange(of: color) { newValue in
                                self.colorValid = self.checkTextFieldValidationName(color)
                                self.allValid = self.onButton(titleValid, descriptionValid, placeValid, phoneValid, dateValid, breedValid, colorValid)
                            }
                        
                        TextField("Место", text: $place)
                            .frame(width: 320, height: 55)
                            .multilineTextAlignment(.center)
                            .lineLimit(0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(placeValid ? Color.orange : Color.black, lineWidth: 1)
                                    .opacity(placeValid ? 1 : 0.2)
                            )
                            .animation(.spring())
                            .onChange(of: place) { newValue in
                                self.placeValid = self.checkTextFieldValidationName(place)
                                self.allValid = self.onButton(titleValid, descriptionValid, placeValid, phoneValid, dateValid, breedValid, colorValid)
                            }
                        
                        TextField("Телефон", text: $phone)
                            .frame(width: 320, height: 55)
                            .multilineTextAlignment(.center)
                            .lineLimit(0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(phoneValid ? Color.orange : Color.black, lineWidth: 1)
                                    .opacity(phoneValid ? 1 : 0.2)
                            )
                            .animation(.spring())
                            .onChange(of: phone) { newValue in
                                self.phoneValid = self.checkTextFieldValidationName(phone)
                                self.allValid = self.onButton(titleValid, descriptionValid, placeValid, phoneValid, dateValid, breedValid, colorValid)
                            }
                        
                        TextField("Дата", text: $date)
                            .frame(width: 320, height: 55)
                            .multilineTextAlignment(.center)
                            .lineLimit(0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(dateValid ? Color.orange : Color.black, lineWidth: 1)
                                    .opacity(dateValid ? 1 : 0.2)
                            )
                            .animation(.spring())
                            .onChange(of: date) { newValue in
                                self.dateValid = self.checkTextFieldValidationName(date)
                                self.allValid = self.onButton(titleValid, descriptionValid, placeValid, phoneValid, dateValid, breedValid, colorValid)
                            }
                    }
                    Button("Добавить пост") {
                        var parametrs:[String:Any] = [:]
                        var catParametrs:[String:Any] = [:]
                        
                        var userId = UserDefaults.standard.string(forKey: "userId")
                        
                        parametrs["title"] = title
                        parametrs["description"] = description
                        parametrs["phone"] = phone
                        parametrs["date"] = date
                        parametrs["userOwnId"] = userId
                        parametrs["place"] = place
                        parametrs["image"] = "noImage"
                        catParametrs["breed"] = breed
                        catParametrs["color"] = color
                        parametrs["cat"] = catParametrs
                        
                        needReload = true
                        
                        viewModel.addPosts(parametrs)
                    }
                    .frame(width: 320, height: 55)
                    .foregroundColor(Color.white)
                    .background(allValid ? Color.indigo : Color.orange)
                    .opacity(allValid ? 0.5 : 1)
                    .cornerRadius(20)
                    .buttonStyle(.automatic)
                    .disabled(allValid)
                    .animation(.spring())
                    .padding(.top, 30)
                }
            }
            .onAppear() {
                needReload = false
            }
            .padding(.bottom, 40)
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
    
    private func delay() async {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        goNext = true
        mode.wrappedValue.dismiss()
    }
}

struct AddPostsView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostsView()
    }
}
