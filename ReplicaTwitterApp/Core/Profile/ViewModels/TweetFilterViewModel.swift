//
//  TweetFilterViewModel.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    
    case tweets
    case repliles
    case likes
    
    
    var title: String {
        
        switch self {
            
        case.tweets: return "Tweets"
        case.repliles: return "Replies"
        case.likes: return "Likes"
        }
    }
    
}
