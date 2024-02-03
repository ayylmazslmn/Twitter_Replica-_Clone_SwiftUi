//
//  ProfileView.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @ObservedObject var viewModel: ProfileViewModel
    
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    
    
    init(user: User) {
        
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            headerView
            
            actionButtons
            
            userInfoDetails
            
            tweetFilterBar
            
            tweetsView
            
        Spacer()

        }
        .navigationBarHidden(true)
    }
       
        
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id:NSUUID().uuidString,
                               username: "ayylmazsuleyman",
                               fullname: "Süleyman Ayyılmaz",
                               profileImageUrl: "",
                               email: "ayylmazsuleyman@gmail.com"))
    }
}

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            VStack {
                Button {
                    mode.wrappedValue.dismiss()
                    // Your action here
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: -4)
                }
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
                    .offset(x: 20, y: 24)
            }
        }
        .frame(height: 100)
    }
    
    var actionButtons: some View {
        HStack(spacing: 12) {
            Spacer()
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.80))
            Button {
                // Your action here
            } label: {
                Text(viewModel.actionButtonTitle)
                    .font(.subheadline)
                    .bold()
                    .frame(width: 120, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
            }
        }
        .padding(.trailing)
    }
    
    var userInfoDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(viewModel.user.fullname)
                    .font(.title2)
                    .bold()
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Junior İOS Developer")
                .font(.subheadline)
                .padding(.vertical)
            HStack (spacing: 40){
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Çeşme, İzmir")
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "link")
                    Text("www.github.com")
                }
            }
            
            UserStatsView()
            
                .padding(.vertical)
        }
        .padding(.horizontal)
    }
    
    var tweetFilterBar:some View {
        
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear)) // Fixed syntax error
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x:0 , y:16))
    }
    
    var tweetsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.tweets(forFilter: self.selectedFilter)) { tweet in
                    TweetRowView(tweet: tweet)
                        .padding()
                }
            }
        }
    }
}
