//
//  UserService.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 1.02.2024.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                guard let documentSnapshot = snapshot else  { return }
                
                // Burada documentSnapshot ile işlemleri yapabilirsiniz
                // Örneğin, kullanıcıyı çıkarmak için
                if let user = try? documentSnapshot.data(as: User.self) {
                    completion(user)
                }
            }
    }
    
    func fetchUsers(completion: @escaping ([User]) -> Void) {
       
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documentSnapshots = snapshot?.documents else  { return }
                
                let users = documentSnapshots.compactMap({ try? $0.data(as: User.self) })
                
                completion(users)
            }
    }
}
