//
//  ChannelChatViewModel.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import Foundation
import Firebase

class ChannelChatViewModel: ObservableObject {
    @Published var messages = [ChannelMessage]()
    let channel: Channel

    init(channel: Channel) {
        self.channel = channel
        fetchMessages()
    }

    func fetchMessages() {
        guard let channelId = channel.id else { return }
        
        let query = COLLECTION_CHANNELS
            .document(channelId)
            .collection("messages")
            .order(by: "timestamp", descending: false)
        
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }

            for document in documents {
                let data = document.data() // Directly accessing the data without optional binding
                print("Document data: \(data)")
            }
        }

        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }

            var newMessages = changes.compactMap { try? $0.document.data(as: ChannelMessage.self) }

            for message in newMessages where message.fromId != AuthViewModel.shared.userSession?.uid {
                self.fetchUser(for: message) { user in
                    if let user = user {
                        self.updateMessage(message, with: user)
                    }
                }
            }

            self.messages.append(contentsOf: newMessages)
        }

        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            var newMessages = documents.compactMap { try? $0.data(as: ChannelMessage.self) }

            for message in newMessages where message.fromId != AuthViewModel.shared.userSession?.uid {
                self.fetchUser(for: message) { user in
                    if let user = user {
                        self.updateMessage(message, with: user)
                    }
                }
            }

            self.messages = newMessages
        }
    }

    func sendMessage(_ messageText: String) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }

        let data: [String: Any] = [
            "text": messageText,
            "fromId": currentUid,
            "channelId": channel.id!,
            "read": false,
            "timestamp": Timestamp(date: Date())
        ]

        COLLECTION_CHANNELS.document(channel.id!)
            .collection("messages")
            .addDocument(data: data)

        COLLECTION_CHANNELS.document(channel.id!)
            .updateData(["lastMessage": messageText, "timestamp": Timestamp(date: Date())])
    }

    private func fetchUser(for message: ChannelMessage, completion: @escaping (User?) -> Void) {
        COLLECTION_USERS.document(message.fromId).getDocument { snapshot, _ in
            guard let data = snapshot?.data(), let user = try? snapshot?.data(as: User.self) else {
                completion(nil)
                print("failed to get user for message")
                return
            }
            completion(user)
        }
    }

    private func updateMessage(_ message: ChannelMessage, with user: User) {
        print("updating message with user")
        if let index = self.messages.firstIndex(where: { $0.id == message.id }) {
            self.messages[index].user = user
            self.objectWillChange.send()
        }
    }
}




