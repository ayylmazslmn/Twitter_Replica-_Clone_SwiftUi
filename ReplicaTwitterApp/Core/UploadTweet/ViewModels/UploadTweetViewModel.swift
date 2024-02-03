//
//  UploadTweetViewModel.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 2.02.2024.
//

import Foundation

class  UploadTweetViewModel: ObservableObject {
    
    @Published var didUploadTweet = false
    
    let service = TweetService()
    
    
    func uploadTweet(withCaption caption: String) {
        
        service.uploadTweet(caption: caption) { success in
            
            if success {
                
                self.didUploadTweet = true
                
            } else {
                
                
            }
            
            }
    }
}
