//
//  ProfileViewModel.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 2.02.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    @Published var likedTweet = [Tweet] ()
    
    private let service = TweetService()
    private let userService = UserService()
let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserTweets()
        self.fetchLikedTweets()
        
    }
    
    var actionButtonTitle: String {
        
        return user.isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    
    func tweets(forFilter filter: TweetFilterViewModel) -> [Tweet] {
        switch filter {
            case .tweets:
                return tweets
        case .repliles:
                return tweets
            case .likes:
                return likedTweet
        }
    }
    
    func fetchUserTweets () {
        
        guard let uid = user.id else { return}
        service.fetchTweets(foruid: uid) { tweets in
            
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                
                self.tweets[i].user = self.user
            }
        }
    }
    
    func fetchLikedTweets() {
            guard let uid = user.id else { return }
            
            service.fetchLikedTweets(forUid: uid) { tweets in
                self.likedTweet = tweets
                
                for i in 0 ..< tweets.count {
                    
                    let uid = tweets[i].uid
                    
                    self.userService.fetchUser(withUid: uid) { user in
                        // Handle user data if needed
                        self.likedTweet[i].user = user
                    }
                }
              
                    }
                }
            }
   
