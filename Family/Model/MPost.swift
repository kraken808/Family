//
//  MPost.swift
//  Family
//
//  Created by Murat Merekov on 05.12.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit

import FirebaseFirestore

struct MPost: Hashable, Decodable{
    let id = UUID().uuidString
    var name: String
    var imageUrl: String
    var postOwnerId: String
    var numberOfUsers: String
    var postId: String
    var category: String
    var publicationDate: Date
    var period: String
    
    static func == (lhs: MPost, rhs: MPost) -> Bool {
        return lhs.postId == rhs.postId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(postId)
    }
    init(name: String,imageUrl: String,postOwnerId: String,numberOfUsers: String, category: String, period: String){
        self.name = name
        self.imageUrl = imageUrl
        self.postOwnerId = postOwnerId
        self.postId = id
        self.numberOfUsers = numberOfUsers
        self.category = category
        self.period = period
        self.publicationDate = Date()
    }
    var convert: [String: Any] {
//        let rep: [String: Any] = [
//                   "created": sentDate,
//                   "senderID": sender.senderId,
//                   "senderName": sender.displayName,
//                   "content": content
//               ]
//               return rep
        var temp: [String: Any] = ["name": name]
        temp["imageUrl"] = imageUrl
        temp["postOwnerId"] = postOwnerId
        temp["postId"] = postId
        temp["numberOfUsers"] = numberOfUsers
        temp["publicationDate"] = publicationDate
        temp["category"] = category
        temp["period"] = period
           return temp
       }
    init?(document: QueryDocumentSnapshot) {
           let data = document.data()
             guard let name = data["name"] as? String,
              let imageUrl = data["imageUrl"] as? String,
              let postOwnerId = data["postOwnerId"] as? String,
              let category = data["category"] as? String,
              let postId = data["postId"] as? String,
              let numberOfUsers = data["numberOfUsers"] as? String,
             
              let period = data["period"] as? String else { return nil }
         guard let publicationDate = data["publicationDate"] as? Timestamp else { return nil }
              self.name = name
              self.imageUrl = imageUrl
              self.postOwnerId = postOwnerId
              self.postId = postId
              self.numberOfUsers = numberOfUsers
        self.category = category
              self.publicationDate = publicationDate.dateValue()
              self.period = period
         
          }
    
   
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}

