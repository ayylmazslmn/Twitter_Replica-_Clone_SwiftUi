//
//  FeedViewModel.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 2.02.2024.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    let service = TweetService()
    let userService = UserService()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        service.fetchTweets { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                
                let uid = tweets[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    // Handle user data if needed
                    self.tweets[i].user = user
                }
            }
          
           
        }
    }
}
