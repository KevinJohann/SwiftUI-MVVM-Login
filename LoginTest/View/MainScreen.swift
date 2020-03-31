//
//  MainScreen.swift
//  LoginTest
//
//  Created by Kevin Torres on 29-03-20.
//  Copyright © 2020 Kevin Torres. All rights reserved.
//

import SwiftUI

struct MainScreen: View {
    let username: String?
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Welcome, \(username ?? "")")
            }
        }.navigationBarHidden(true)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(username: "")
    }
}
