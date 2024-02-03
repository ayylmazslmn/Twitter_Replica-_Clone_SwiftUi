//
//  SideMenuView.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import SwiftUI

import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        if let user = authViewModel.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                ProfileSectionView(user: user)
                SideMenuOptionsView(authViewModel: authViewModel, user: user)
                Spacer()
            }
            .padding(.leading)
        }
    }
}

struct ProfileSectionView: View {
    let user: User

    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullname)
                    .font(.headline)

                Text("@\(user.username)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            UserStatsView()
                .padding(.vertical)
        }
    }
}

struct SideMenuOptionsView: View {
    @ObservedObject var authViewModel: AuthViewModel
    let user: User

    var body: some View {
        ForEach(SideMenuViewModel.allCases, id: \.rawValue) { viewModel in
            switch viewModel {
            case .profile:
                NavigationLink(destination: ProfileView(user: user)) {
                    SideMenuOptionRowView(viewModel: viewModel)
                }

            case .logout:
                Button(action: {
                    authViewModel.singOut()
                }) {
                    SideMenuOptionRowView(viewModel: viewModel)
                }

            default:
                SideMenuOptionRowView(viewModel: viewModel)
            }
        }
        .padding(.vertical, 4)
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

