//
//  AppDelegate.swift
//  Family
//
//  Created by Murat Merekov on 31.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    func getUsername(email: String)-> String{
        let components = email.components(separatedBy: "@")
        return components[0]
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
      if let error = error {
        print(error.localizedDescription)
           return
         }

         guard let authentication = user.authentication else { return }
         let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
       
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    
   @available(iOS 9.0, *)
   func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
     -> Bool {
     return GIDSignIn.sharedInstance().handle(url)
   }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

