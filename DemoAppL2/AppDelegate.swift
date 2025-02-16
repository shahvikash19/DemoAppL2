//
//  AppDelegate.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 13/02/25.
//

//  AppDelegate.swift
//  DemoAppL2
//
//  Created by Vikas Hareram Shah on 13/02/25.

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure Firebase
      //  FirebaseApp.configure()
       // GIDSignIn.sharedInstance()?.clientID = "877137330494-9pqqjjlpsq5pis45q7tdnavch5sre5ju.apps.googleusercontent.com"
        
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        UITextField.appearance().textAlignment = .left
        return true
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        // Handle Google Sign-In URL
//        return GIDSignIn.sharedInstance.handle(url)
//    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Handle scene session discard
    }
}
