//
//  Category.swift
//  Family
//
//  Created by Murat Merekov on 17.12.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit

import FirebaseFirestore

struct MCategory: Hashable, Decodable{
    let id = UUID().uuidString
    var name: String
    var imageUrl: String
    var categoryId: String
    
    static func == (lhs: MCategory, rhs: MCategory) -> Bool {
        return lhs.categoryId == rhs.categoryId
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryId)
    }
    init(name: String,imageUrl: String){
        
        self.name = name
        self.imageUrl = imageUrl
        self.categoryId = id
    }
    var convert: [String: Any] {
        let rep: [String: Any] = [
                   "name": name,
                   "imageUrl": imageUrl,
                   "categoryId": categoryId,
                 
               ]
               return rep
//        var temp: [String: Any] = ["name": name]
//        temp["imageUrl"] = imageUrl
//        temp["categoryId"] = categoryId
//           return temp
       }
    
    
    init?(document: QueryDocumentSnapshot) {
           let data = document.data()
             guard let name = data["name"] as? String,
              let imageUrl = data["imageUrl"] as? String,
               let categoryId = data["categoryId"] as? String else { return nil }
                     
                         
                     self.name = name
                     self.imageUrl = imageUrl
                     self.categoryId = categoryId
            
         
          }
    
  
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}

