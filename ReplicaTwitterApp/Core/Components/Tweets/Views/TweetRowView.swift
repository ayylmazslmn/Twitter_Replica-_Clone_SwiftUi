//
//  TweetRowView.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @ObservedObject var  viewModel: TweetRowViewModel
    
    init(tweet: Tweet) {
        
        self.viewModel = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Profile image, user info, and tweet
            
            if let user = viewModel.tweet.user {
                
                HStack(alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 65, height: 65)
                        .clipShape(Circle())
                        
                      
                    
                    // User info and tweet
                    VStack(alignment: .leading, spacing: 4) {
                        // User info
                        
                        
                        HStack {
                            
                            Text(user.fullname)
                                .font(.subheadline).bold()
                            
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                            Text("1d")
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                            
                        }
                       
                        // Tweet
                        Text(viewModel.tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                        
                        
                    }
                }
            }
            
            
            // Action buttons
            HStack {
                Button {
                    // Action goes here
                } label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button {
                    // Action goes here
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button {
                
                    viewModel.tweet.didLike ?? false ?
                    viewModel.unlikeTweet() :
                    viewModel.likeTweet()
                } label: {
                    Image(systemName: viewModel.tweet.didLike ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.tweet.didLike ??  false ?  .red : .gray )
                }
                
                Spacer()
                
                Button {
                    // Action goes here
                } label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }
            }
            .padding()
            .foregroundColor(.gray)
            
            Divider()
        }
    }
    
}
    
  /* struct TweetRowView_Previews: PreviewProvider {
        static var previews: some View {
            TweetRowView(tweet: tweet)
        }
    }

*/
