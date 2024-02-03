//
//  ExploreViewModel.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 1.02.2024.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published  var users = [User]()
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        
        if searchText.isEmpty{
            return users
        } else{
            
            let lowercasedQuerry = searchText.lowercased()
                 
            return users.filter({
                
                $0.username.contains(lowercasedQuerry) ||
                
                $0.fullname.lowercased().contains(lowercasedQuerry)
            })

        }
    }
    
    let service =   UserService()
    
    
    init() {
        
        fetchUsers()
    }
    
    func  fetchUsers() {
        
        service.fetchUsers  { users in
            
            self.users = users
         
            
        }
    }
}
