//
//  ContentViewModel.swift
//  LoginTest
//
//  Created by Kevin Torres on 29-03-20.
//  Copyright © 2020 Kevin Torres. All rights reserved.
//

import Foundation

final class ContentViewModel: NSObject, ObservableObject {
    typealias authenticationLoginCallBack = (_ statusBool: Bool,_ message: String) -> Void
    
    var loginCallBack: authenticationLoginCallBack?
    var user: User!
    var userDataManager: UserDataManagerProtocol?
    var username: String { return user.userName }
    
    init(dataManager: UserDataManagerProtocol = UserDataManager.shared) {
        self.userDataManager = dataManager
    }
    
    func autenticateUserWith(_ username: String, andPassword password: String) {
        if username.count != 0 {
            if password.count != 0 {
                verifyUserWith(username, andPassword: password)
            } else {
                // Password empty
                self.loginCallBack?(false, "Password should not be empty")
            }
        } else {
            // Username empty
            self.loginCallBack?(false, "Username sould not be empty")
        }
    }
    
    fileprivate func verifyUserWith(_ username: String, andPassword password: String) {
        guard let data = userDataManager?.getUser() else {
            return
        }
        
        //        let userInData = data.filter({ $0.userName == username })
        
        guard let encryptedPassword = AES256CBC.encryptString(username, password: password) else {
            return
        }
        if let decryptPassword = AES256CBC.decryptString(encryptedPassword, password: password) {
            user = User(userName: username, password: password)
            self.loginCallBack?(true, "Success")
        } else {
            self.loginCallBack?(false, "Failure, enter valid credentials.")
        }
    }
    
    func loginCompletionHandler(callBack: @escaping authenticationLoginCallBack) {
        self.loginCallBack = callBack
    }
}
