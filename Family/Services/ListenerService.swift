//
//  ListenerService.swift
//  Family
//
//  Created by Murat Merekov on 15.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class ListenerService {
    
    static let shared = ListenerService()

    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func usersObserve(users: [MUser], completion: @escaping (Result<[MUser], Error>) -> Void) -> ListenerRegistration? {
        var users = users
        let usersListener = usersRef.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { (diff) in
                guard let muser = MUser(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !users.contains(muser) else { return }
                    guard muser.uid != self.currentUserId else { return }
                    users.append(muser)
                case .modified:
                    guard let index = users.firstIndex(of: muser) else { return }
                    users[index] = muser
                case .removed:
                    guard let index = users.firstIndex(of: muser) else { return }
                    users.remove(at: index)
                }
            }
            completion(.success(users))
        }
        return usersListener
    } // usersObserve
    
    func itemsObserve(items: [MPost], completion: @escaping (Result<[MPost], Error>) -> Void) -> ListenerRegistration? {
        var items = items
        let usersListener = db.collection("posts").addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
               
                return
            }
            snapshot.documentChanges.forEach { (diff) in
                guard let mpost = MPost(document: diff.document) else { return }
               
                switch diff.type {
                case .added:
                    items.append(mpost)
                case .modified:
                    guard let index = items.firstIndex(of: mpost) else { return }
                    items[index] = mpost
                case .removed:
                    guard let index = items.firstIndex(of: mpost) else { return }
                    items.remove(at: index)
                }
            }
            completion(.success(items))
        }
        return usersListener
    } // itemsObserve
    
    func categoryObserve(categories: [MCategory], completion: @escaping (Result<[MCategory], Error>) -> Void) -> ListenerRegistration? {
        var categories = categories
        let categoryListener = db.collection("category").addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { (diff) in
                guard let mcategory = MCategory(document: diff.document) else { return }
              
                switch diff.type {
                case .added:
                    categories.append(mcategory)
                case .modified:
                    guard let index = categories.firstIndex(of: mcategory) else { return }
                    categories[index] = mcategory
                case .removed:
                    guard let index = categories.firstIndex(of: mcategory) else { return }
                    categories.remove(at: index)
                }
            }
            completion(.success(categories))
        }
        return categoryListener
    } // usersObserve

    
    func activeChatsObserve(chats: [MChat], completion: @escaping (Result<[MChat], Error>) -> Void) -> ListenerRegistration? {
        var chats = chats
        let chatsRef = db.collection(["users", currentUserId, "activeChats"].joined(separator: "/"))
        let chatsListener = chatsRef.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let chat = MChat(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !chats.contains(chat) else { return }
                    chats.append(chat)
                case .modified:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats[index] = chat
                case .removed:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats.remove(at: index)
                }
            }
            
            completion(.success(chats))
        }
        
        return chatsListener
    }
    
    func messagesObserve(chat: MChat, completion: @escaping (Result<MMessage, Error>) -> Void) -> ListenerRegistration? {
        let ref = usersRef.document(currentUserId).collection("activeChats").document(chat.friendId).collection("messages")
        let messagesListener = ref.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let message = MMessage(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    completion(.success(message))
                case .modified:
                    break
                case .removed:
                    break
                }
            }
        }
        return messagesListener
    }
}
