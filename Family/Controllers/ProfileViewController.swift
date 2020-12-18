//
//  ProfileViewController.swift
//  Family
//
//  Created by Murat Merekov on 31.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
        
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        navigationItem.title = "Profile"
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem?.tintColor = .blue
        
        
        
   
    }
    
   
    @objc func signOut(){
        let ac = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .alert)
               ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               ac.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
                   do {
                       try Auth.auth().signOut()
                       UIApplication.shared.keyWindow?.rootViewController = LoginViewController()
                   } catch {
                       print("Error signing out: \(error.localizedDescription)")
                   }
               }))
               present(ac, animated: true, completion: nil)
    }

}
