//
//  LoginView.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        // parent
        VStack{
            // header
        AuthenticaitonHeaderView(title1: "Hi", title2: "Welcome Back")
            
            VStack(spacing: 40){
                
                CustomInputField(imageName: "envelope.fill",
                                 placeholderText: "Email",
                                 text: $email)
                
                CustomInputField(imageName: "lock.fill",
                                 placeholderText: "Password",
                                 isSecureField: true,
                                 text: $password)
                
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack{
                
                Spacer()
                
                NavigationLink {
                    Text("Reset password view..")
                } label: {
                    Text("Forgot password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing , 30)
                }
                
            }
            
            Button {
                viewModel.login(withEmail: email, password: password)
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
                }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)

            
            
            
            Spacer()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
                
            } label: {
                HStack{
                    Text("Don't have an acconut?")
                        .font(.footnote)
                    
                        Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold   )
                }
            }
            .padding(.bottom, 50)
            .foregroundColor(Color(.systemBlue))

            
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

