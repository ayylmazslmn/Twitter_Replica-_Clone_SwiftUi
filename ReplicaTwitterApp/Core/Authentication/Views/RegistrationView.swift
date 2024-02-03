//
//  RegistrationView.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        VStack{
            
            
            NavigationLink(
                destination: ProfilePhotoSelectorView(),
                isActive: $viewModel.didAuthenticateUser)
            {
                EmptyView()
            }
            
            AuthenticaitonHeaderView(title1: "Get started", title2: "Create Your Account")
            VStack(spacing: 40){
                CustomInputField(imageName: "envelope.fill",
                                 placeholderText: "Email",
                                 text: $email)
                
                CustomInputField(imageName: "person.fill",
                                 placeholderText: "Username",
                                 text: $username)
                
                CustomInputField(imageName: "person.fill",
                                 placeholderText: "Fullname",
                                 text: $fullname)
                
                
                CustomInputField(imageName: "lock.fill",
                                 placeholderText: "Password",
                                 isSecureField: true,
                                 text: $password)
                
            }
            .padding(40)
            
            Button {
                viewModel.register(withEmail: email,
                                   password: password,
                                   fullname: fullname,
                                   username: username)
                
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
                }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
                Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                
                HStack{
                    Text("Alraady have an acconut?")
                        .font(.footnote)
                    
                        Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold   )
                }
            }
            .padding(.bottom, 50)
            .foregroundColor(Color(.systemBlue))

        
        }
        .ignoresSafeArea()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
