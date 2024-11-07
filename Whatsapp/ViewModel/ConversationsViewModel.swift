//
//  ConversationsViewModel.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import Foundation

class ConversationsViewModel: ObservableObject {
    
    @Published var recentMessages = [Message]()
    
    init() {
        fetchRecentMessages()
    }

    func fetchRecentMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_MESSAGES
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.recentMessages = documents.compactMap({try? $0.data(as: Message.self)})
        }
    }
    
}
