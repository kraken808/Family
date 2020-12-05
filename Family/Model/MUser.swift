//
//  MUser.swift
//  Family
//
//  Created by Murat Merekov on 05.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct MUser: Hashable, Decodable{
    var name: String
    var lastname: String
    var email: String
    var birthdate: String
    var avatarURL: String
    var sex: String
    var uid: String
    
   
    init(name: String,lastname:String, email: String, birthdate: String, avatarURL: String, sex: String, id: String ) {
        self.name = name
        self.lastname = lastname
        self.email = email
        self.birthdate = birthdate
        self.avatarURL = avatarURL
        self.sex = sex
        self.uid = id
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let name = data["name"] as? String,
        let email = data["email"] as? String,
        let birthdate = data["birthdate"] as? String,
        let avatarStringURL = data["avatarURL"] as? String,
        let lastname = data["lastname"] as? String,
        let sex = data["sex"] as? String,
        let id = data["uid"] as? String else { return nil }
        
        self.name = name
        self.email = email
        self.avatarURL = avatarStringURL
        self.lastname = lastname
        self.birthdate = birthdate
        self.sex = sex
        self.uid = id
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
           guard let name = data["name"] as? String,
           let email = data["email"] as? String,
           let birthdate = data["birthdate"] as? String,
           let avatarStringURL = data["avatarURL"] as? String,
           let lastname = data["lastname"] as? String,
           let sex = data["sex"] as? String,
           let id = data["uid"] as? String else { return nil }
           
           self.name = name
           self.email = email
           self.avatarURL = avatarStringURL
           self.lastname = lastname
           self.birthdate = birthdate
           self.sex = sex
           self.uid = id

       }
    
    var convert: [String: Any] {
          var temp = ["name": name]
         temp["lastname"] = lastname
          temp["email"] = email
          temp["avatarURL"] = avatarURL
          temp["birthdate"] = birthdate
          temp["sex"] = sex
          temp["uid"] = uid
          return temp
      }
    
      func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}
