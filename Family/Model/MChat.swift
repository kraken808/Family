//
//  MChat.swift
//  Family
//
//  Created by Murat Merekov on 14.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct MChat: Hashable, Decodable {
    var friendUsername: String
    var friendAvatarStringURL: String
    var lastMessageContent: String
    var friendId: String
    var friendLastname: String
    
    var convert: [String : Any] {
        var rep = ["friendName": friendUsername]
        rep["friendAvatarURL"] = friendAvatarStringURL
        rep["friendID"] = friendId
        rep["lastMessage"] = lastMessageContent
        rep["friendLastname"] = friendLastname
        return rep
    }
    
    init(friendUsername: String,friendLastname: String, friendAvatarStringURL: String, friendId: String, lastMessageContent: String) {
        self.friendUsername = friendUsername
        self.friendAvatarStringURL = friendAvatarStringURL
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
        self.friendLastname = friendLastname
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUsername = data["friendName"] as? String,
        let friendLastname = data["friendLastname"] as? String,
        let friendAvatarStringURL = data["friendAvatarURL"] as? String,
        let friendId = data["friendID"] as? String,
        let lastMessageContent = data["lastMessage"] as? String else { return nil }
        
        self.friendUsername = friendUsername
        self.friendAvatarStringURL = friendAvatarStringURL
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
          self.friendLastname = friendLastname
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }

    
   
}
