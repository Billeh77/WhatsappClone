//
//  WhatsappApp.swift
//  Whatsapp
//
//  Created by Emile Billeh on 27/05/2024.
//

import SwiftUI
import Firebase

@main
struct WhatsappApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
