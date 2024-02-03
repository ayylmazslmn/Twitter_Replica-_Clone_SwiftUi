//
//  ReplicaTwitterAppApp.swift
//  ReplicaTwitterApp
//
//  Created by Süleyman Ayyılmaz on 30.01.2024.
//

import SwiftUI
import Firebase



@main
struct ReplicaTwitterAppApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    
    init() {
        
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    
            }
            .environmentObject(viewModel)
        }
    }
}
