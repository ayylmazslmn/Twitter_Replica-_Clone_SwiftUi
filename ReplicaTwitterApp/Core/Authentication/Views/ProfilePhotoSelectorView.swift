//
//  ProfilePhotoSelectorView.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 31.01.2024.
//

    import SwiftUI

    struct ProfilePhotoSelectorView: View {
        @State private var showImagePıcker = true
        @State private var selectedImage : UIImage?
        @State private var profileImage : Image?
        @EnvironmentObject var viewModel: AuthViewModel
            
        var body: some View {
            
            VStack{
                AuthenticaitonHeaderView(title1: "Create Your Account",
                                         title2: "Addd A Profile Photo")
                
                Button {
                    showImagePıcker.toggle()
                } label: {
                    if let profileImage = profileImage{
                        profileImage
                            .resizable()
                            .modifier(ProfileImageModifier())
                        
                    } else {
                        
                        Image("plus")
                            
                            .renderingMode(.template)
                            .modifier(ProfileImageModifier())
                    }
                }
                .sheet(isPresented: $showImagePıcker,
                       onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                .padding(.top, 44)
                
                if let selectedImage = selectedImage  {
                    
                    Button {
                     
                        viewModel.uploadProfileImage(selectedImage)
                        
                    } label: {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 340, height: 50)
                            .background(Color(.systemBlue))
                            .clipShape(Capsule())
                            .padding()
                        }
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                }

                
                Spacer()
            }
            .ignoresSafeArea()
            }
        func loadImage() {
            guard let selectedImage = selectedImage else { return }
            
            profileImage = Image(uiImage: selectedImage)
        }
    }

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        content
           
          
            .foregroundColor(Color(.systemBlue))
            .scaledToFit()
            .frame(width: 200, height: 200)
           
            .clipShape(Circle())
        
    }
}

    struct ProfilePhotoSelectorView_Previews: PreviewProvider {
        static var previews: some View {
            ProfilePhotoSelectorView()
        }
    }
