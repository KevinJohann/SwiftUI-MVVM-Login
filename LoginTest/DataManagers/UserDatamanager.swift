//
//  UserDatamanager.swift
//  LoginTest
//
//  Created by Kevin Torres on 29-03-20.
//  Copyright © 2020 Kevin Torres. All rights reserved.
//

import Foundation

protocol UserDataManagerProtocol: AnyObject {
    func getUser() -> [User]
}

class UserDataManager: UserDataManagerProtocol {
    static let shared: UserDataManagerProtocol = UserDataManager()

    func getUser() -> [User] {
        guard let data = UserDefaults.standard.value(forKey:"users") as? Data else { return [] }
        let user = try! PropertyListDecoder().decode(Array<User>.self, from: data)
        return user
    }
}
