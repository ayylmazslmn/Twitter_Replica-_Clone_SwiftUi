//
//  UserStatsView.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
     
        HStack (spacing: 40){
                   HStack {
                      Text("212")
                           .font(.subheadline)
                           .bold()
                       
                       Text("Following")
                           .font(.caption)
                           .foregroundColor(.gray)
                   }
             
        
            HStack {
               Text("212")
                    .font(.subheadline)
                    .bold()
                
                Text("Followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
           }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
