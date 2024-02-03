//
//  TweetService.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 2.02.2024.
//

import Firebase

struct TweetService {
    
    func uploadTweet(caption: String, completion: @escaping (Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        Firestore.firestore().collection("tweets").document().setData(data) { error in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch tweets with error: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                // Correct the typo here (change '0' to 'document')
                let tweets = documents.compactMap({ document in
                    try? document.data(as: Tweet.self)
                })
                
                completion(tweets)
            }
    }
    func fetchTweets(foruid uid: String, completion: @escaping ([Tweet]) -> Void) {
        
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch tweets with error: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                // Correct the typo here (change '0' to 'document')
                let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
                
                completion(tweets.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                
                
            }
    }
    
 

    
}

/// LİKES

extension  TweetService {
    func likeTweet(_ tweet:  Tweet, completion: @escaping() -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes": tweet.likes + 1]) { _ in
                userLikesRef.document(tweetId).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard  tweet.likes > 0  else { return }
        
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes": tweet.likes - 1]) { _ in
                userLikesRef.document(tweetId).delete() { _ in
                    completion()
                }
            }
    }
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool)  -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else  {return}
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetId).getDocument { snapshot, _ in
                
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func fetchLikedTweets(forUid uid: String , completion: @escaping ([Tweet])  -> Void ) {
        
        var tweets = [Tweet]()
        print("fetchLikedTweets")
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                            tweets.append(tweet)
                            
                            completion(tweets)
                            
                        }
                }
            }
    }
}
