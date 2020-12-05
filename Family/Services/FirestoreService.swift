//
//  FirestoreService.swift
//  Family
//
//  Created by Murat Merekov on 11.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import Firebase
import FirebaseFirestore

class FirestoreService{
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    var currentUser: MUser!
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void){
        let dataRef = db.collection("users").document(user.uid)
        dataRef.getDocument { (document, error) in
               if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                       completion(.failure(UserError.cannotUnwrapToMUser))
                       return
                   }
                   self.currentUser = muser
                   completion(.success(muser))
               } else {
                   completion(.failure(UserError.cannotGetUserInfo))
               }
           }
    }
    
    func saveUserInfo(id: String, email: String, name: String?, lname: String?, avatarImage: UIImage?, sex: String?, dbirth:String, completion: @escaping (Result<MUser, Error>) -> Void){
        
        guard avatarImage != #imageLiteral(resourceName: "avatar") else {
//            completion(.failure(UserError.photoNotExist))
            print("error image")
            return
        }
        
        
             
             var muser = MUser(name: name!,
                               lastname: lname!,
                               email: email,
                               birthdate: dbirth,
                               avatarURL: "not exist",
                               sex: sex!,
                               id: id)
        
                print("\n---------\n")
                print("current user is: \(muser)")
                
                print("\n---------\n")
        let newUserRef = db.collection("users").document(id)
        StorageService.shared.upload(photo: avatarImage!){ (result) in
            switch result {
                
            case .success(let url):
                muser.avatarURL = url.absoluteString
                 newUserRef.setData(muser.convert)
                completion(.success(muser))
            case .failure(let error):
                completion(.failure(error))
             
            }
        }
    
    }
    func createActiveChat(user: MUser, message: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        print("\n---------\n")
//        print("current user is: \(currentUser)")
//        print("\n---------\n")
         
          let messageRef = db.collection(["users", currentUser.uid, "activeChats"].joined(separator: "/")).document(user.uid).collection("messages")
        
        let chat = MChat(friendUsername: user.name,
                         friendLastname: user.lastname,
                         friendAvatarStringURL: user.avatarURL,
                         friendId: user.uid,
                         lastMessageContent: message)
        
          db.collection(["users", currentUser.uid, "activeChats"].joined(separator: "/")).document(chat.friendId).setData(chat.convert) { (error) in
              if let error = error {
                  completion(.failure(error))
                  return
              }
            let message = MMessage(user: user, content: message)
              
                  messageRef.addDocument(data: message.representation) { (error) in
                      if let error = error {
                          completion(.failure(error))
                          return
                      }
                      completion(.success(Void()))
                  }
              
          }
      }
    func getActiveChatMessages(chat: MChat, completion: @escaping (Result<[MMessage], Error>) -> Void) {
        let reference = db.collection(["users", currentUser.uid, "activeChats"].joined(separator: "/")).document(chat.friendId).collection("messages")
        var messages = [MMessage]()
        reference.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            for document in querySnapshot!.documents {
                guard let message = MMessage(document: document) else { return }
                messages.append(message)
            }
            completion(.success(messages))
        }
    }
      
      func sendMessage(chat: MChat, message: MMessage, completion: @escaping (Result<Void, Error>) -> Void) {
          let friendRef = db.collection("users").document(chat.friendId).collection("activeChats").document(currentUser.uid)
          let friendMessageRef = friendRef.collection("messages")
          let myMessageRef = db.collection("users").document(currentUser.uid).collection("activeChats").document(chat.friendId).collection("messages")
          
        let chatForFriend = MChat(friendUsername: currentUser.name,
                                  friendLastname: currentUser.lastname,
                                  friendAvatarStringURL: currentUser.avatarURL,
                                  friendId: currentUser.uid,
                                  lastMessageContent: message.content)
          friendRef.setData(chatForFriend.convert) { (error) in
              if let error = error {
                  completion(.failure(error))
                  return
              }
              friendMessageRef.addDocument(data: message.representation) { (error) in
                  if let error = error {
                      completion(.failure(error))
                      return
                  }
                  myMessageRef.addDocument(data: message.representation) { (error) in
                      if let error = error {
                          completion(.failure(error))
                          return
                      }
                      completion(.success(Void()))
                  }
              }
          }
      }
}
