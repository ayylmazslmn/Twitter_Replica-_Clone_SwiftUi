//
//  Tweet.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 2.02.2024.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
    
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    let likes: Int
    
    var user: User?
    var didLike: Bool? = false
}



