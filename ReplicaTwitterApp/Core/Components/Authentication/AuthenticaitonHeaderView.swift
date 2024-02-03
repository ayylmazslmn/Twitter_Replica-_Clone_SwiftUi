//
//  AuthenticaitonHeaderView.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import SwiftUI

struct AuthenticaitonHeaderView: View {
    
    let title1: String
    let title2: String
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {Spacer()}
            
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
        }
        .frame(height:260)
        .padding(.leading)
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomRight]))
        
    }
}

struct AuthenticaitonHeader_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticaitonHeaderView(title1: "Hi", title2: "Welcome Back")
    }
}
