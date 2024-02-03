//
//  UserRowView.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let   user: User
    var body: some View {
        
        HStack(spacing: 12){
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(user.username)
                    .font(.subheadline).bold()
                    .foregroundColor(.black)
                
                
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
       
    }
}

/*struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView()
    }
}
*/
