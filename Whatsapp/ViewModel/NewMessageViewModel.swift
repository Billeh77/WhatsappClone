//
//  NewMessageViewModel.swift
//  Whatsapp
//
//  Created by Emile Billeh on 27/05/2024.
//

import SwiftUI
import Firebase

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    
    init() {
        fetchUsers()
    }
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter({
                $0.username.contains(lowercasedQuery) ||
                $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap({ try? $0.data(as: User.self)})
                .filter({ $0.id != AuthViewModel.shared.userSession?.uid })
        }
    }
}
