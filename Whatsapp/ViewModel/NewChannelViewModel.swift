//
//  NewChannelViewModel.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import SwiftUI
import Firebase

class NewChannelViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var selectedUsers = [User]()
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
        guard let currentUserId = AuthViewModel.shared.userSession?.uid else { return }

        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap({ try? $0.data(as: User.self) })
                .filter({ $0.id != currentUserId })  // Filter out the current user
        }
    }

    func createChannel(name: String, _ image: UIImage, completion: @escaping (Channel?) -> Void) {
        guard let currentUserId = AuthViewModel.shared.userSession?.uid else { return }
        
        let userIds = selectedUsers.map { $0.id } + [currentUserId]

        let data: [String: Any] = [
            "name": name,
            "userIds": userIds,
            "lastMessage": "",
            "timestamp": Timestamp(date: Date())
        ]

        var newChannelRef: DocumentReference? = nil
        newChannelRef = COLLECTION_CHANNELS.addDocument(data: data) { error in
            if let error = error {
                print("Failed to create channel: \(error.localizedDescription)")
                completion(nil)
            } else {
                guard let newChannelRef = newChannelRef else { return }

                newChannelRef.getDocument { document, error in
                    if let document = document, document.exists {
                        let channel = try? document.data(as: Channel.self)
                        completion(channel)
                    } else {
                        completion(nil)
                    }
                }

                ImageUploader.uploadImage(image: image) { channelImageUrl in
                    COLLECTION_CHANNELS.document(newChannelRef.documentID).updateData(["channelImageUrl": channelImageUrl]) { _ in }
                }
            }
        }
    }
    
    func createChannel(name: String, completion: @escaping (Channel?) -> Void) {
        guard let currentUserId = AuthViewModel.shared.userSession?.uid else { return }
        
        let userIds = selectedUsers.map { $0.id } + [currentUserId]

        let data: [String: Any] = [
            "name": name,
            "userIds": userIds,
            "lastMessage": "",
            "timestamp": Timestamp(date: Date())
        ]

        var newChannelRef: DocumentReference? = nil
        newChannelRef = COLLECTION_CHANNELS.addDocument(data: data) { error in
            if let error = error {
                print("Failed to create channel: \(error.localizedDescription)")
                completion(nil)
            } else {
                guard let newChannelRef = newChannelRef else { return }

                newChannelRef.getDocument { document, error in
                    if let document = document, document.exists {
                        let channel = try? document.data(as: Channel.self)
                        completion(channel)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }

}



