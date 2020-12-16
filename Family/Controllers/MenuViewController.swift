//
//  MenuViewController.swift
//  Family
//
//  Created by Murat Merekov on 31.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UITabBarController {

     var tabBarCntrl: UITabBarController!
    
    private let currentUser: MUser
     
     init(currentUser: MUser = MUser(name: "error",
                                     lastname: "error",
                                     email: "erroer",
                                     birthdate: "error",
                                     avatarURL: "er",
                                     sex: "wer",
                                     id: "srt")) {
         self.currentUser = currentUser
         super.init(nibName: nil, bundle: nil)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.tabBar.barStyle = .black
            let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
                 let msgImage = UIImage(systemName: "message", withConfiguration: boldConfig)!
                 let profileImage = UIImage(systemName: "person", withConfiguration: boldConfig)!
                 let addImage = UIImage(systemName: "plus.circle", withConfiguration: boldConfig)!
                  let mainImage = UIImage(systemName: "rectangle.3.offgrid", withConfiguration: boldConfig)!
            viewControllers = [
                      generateNavigationController(rootViewController: MainViewController(currentUser: currentUser), title: "Main", image: mainImage),
                      generateNavigationController(rootViewController: CreateViewController(currentUser: currentUser), title: "Create", image: addImage),
                      generateNavigationController(rootViewController: ChatViewController(currentUser: currentUser), title: "Message", image: msgImage),
                      generateNavigationController(rootViewController: ProfileViewController(), title: "Profile", image: profileImage)
                      
                  ]
         
            
        }
        
    
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}
