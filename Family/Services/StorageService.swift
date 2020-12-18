//
//  StorageService.swift
//  Family
//
//  Created by Murat Merekov on 12.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//


import UIKit
import FirebaseAuth
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()

    let storageRef = Storage.storage().reference()
    
    private var avatarsRef: StorageReference {
        return storageRef.child("avatars")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func upload(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        
        guard let scaledImage = photo.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.child("avatars").child(currentUserId).putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            self.storageRef.child("avatars").child(self.currentUserId).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }
    func uploadCategory(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
           
           guard let scaledImage = photo.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
           
           let metadata = StorageMetadata()
           metadata.contentType = "image/jpeg"
        let id = UUID().uuidString
           storageRef.child("categories").child(id).putData(imageData, metadata: metadata) { (metadata, error) in
               guard let _ = metadata else {
                   completion(.failure(error!))
                   return
               }
               self.storageRef.child("avatars").child(self.currentUserId).downloadURL { (url, error) in
                   guard let downloadURL = url else {
                       completion(.failure(error!))
                       return
                   }
                   completion(.success(downloadURL))
               }
           }
       }
}
