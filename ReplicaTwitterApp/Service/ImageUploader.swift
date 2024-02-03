//
//  ImageUploader.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 31.01.2024.
//

import Firebase
import UIKit
import FirebaseStorage


struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            
            if let error = error {
                print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL(completion: { imageUrl, _ in
                
                guard let imageUrl = imageUrl?.absoluteString else { return }
                completion(imageUrl)
            })
        }
    }
}

