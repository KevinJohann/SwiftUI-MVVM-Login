//
//  ContentView.swift
//  LoginTest
//
//  Created by Kevin Torres on 28-03-20.
//  Copyright © 2020 Kevin Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentVM = ContentViewModel()
    
    @State var authenticationDidFail: Bool = false
    @State var editingMode: Bool = false
    @State var password: String = ""
    @State var username: String = ""
    @State private var canGoMainScreen: Bool = false
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    WelcomeText()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Username")
                            UsernameTextField(username: $username, editingMode: $editingMode)
                            Divider()
                        }
                    }.padding(12)
                        .background(Color("Color"))
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text("Password")
                            PasswordSecureField(password: $password)
                            Divider()
                        }
                    }.padding(12)
                        .background(Color("Color"))
                    
                    NavigationLink(destination: MainScreen(username: self.username), tag: 1, selection: $selection) {
                        Text("")
//                    NavigationLink(destination: MainScreen(username: "Need to pass user name string"), isActive: self.$canGoMainScreen) { //self.contentVM.username
                        }
                    
                        Button(action: {
                            self.contentVM.autenticateUserWith(self.username, andPassword: self.password)
                            self.contentVM.loginCompletionHandler { (status, message) in
                                if status {
                                    print("Logged in with username \(self.contentVM.username)")
                                    self.canGoMainScreen = true
                                    self.selection = 1
                                } else {
                                    print(message)
                                }
                            }
                        }) {
                            LoginButtonContent()
                        }
                    
                }
            }
        }
    }
}

// MARK: - Welcome text
struct WelcomeText : View {
    var body: some View {
        return Text("Welcome")
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
}

// MARK: - User Name
struct UsernameTextField : View {
    @Binding var username: String
    @Binding var editingMode: Bool
    
    var body: some View {
        return TextField("Username", text: $username, onEditingChanged: {edit in
            if edit == true
            {self.editingMode = true}
            else
            {self.editingMode = false}
        })
            .cornerRadius(5.0)
    }
}

// MARK: - Password
struct PasswordSecureField : View {
    @Binding var password: String
    
    var body: some View {
        return SecureField("Password", text: $password)
            .cornerRadius(5.0)
    }
}

// MARK: - LoginButtonContent
struct LoginButtonContent : View {
    var body: some View {
        return Text("Sign in")
            .font(.headline)
            .padding()
            .frame(width: 220, height: 60)
            .cornerRadius(15.0)
            .border(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

