//
//  User.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 1.02.2024.
//

import FirebaseFirestoreSwift
import Firebase



struct User: Identifiable, Decodable {
    
    @DocumentID var id: String?
    
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
}
