//
//  AppDelegate.swift
//  LoginTest
//
//  Created by Kevin Torres on 28-03-20.
//  Copyright © 2020 Kevin Torres. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initUsers()
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        //
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "LoginTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

// MARK: - Add Users
extension AppDelegate {
    func initUsers() {
        let userName1 = "Kevin"
        let userName2 = "Johan"
        let userName3 = "Root"
        let password = "11111111111111111111111111111111" // 32 bits
        let password2 = "22222222222222222222222222222222" // 32 bits
        let password3 = "33333333333333333333333333333333" // 32 bits

        guard let encryptedPassword = AES256CBC.encryptString(userName1, password: password) else { return }
        guard let encryptedPassword2 = AES256CBC.encryptString(userName2, password: password2) else { return }
        guard let encryptedPassword3 = AES256CBC.encryptString(userName3, password: password3) else { return }

        let users: [User] = [
            User(userName: userName1, password: encryptedPassword),
            User(userName: userName2, password: encryptedPassword2),
            User(userName: userName3, password: encryptedPassword3),
        ]
                        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(users), forKey: "users")
        
        guard let data = UserDefaults.standard.value(forKey:"users") as? Data else { return }
        print(try! PropertyListDecoder().decode(Array<User>.self, from: data))
    }
}
