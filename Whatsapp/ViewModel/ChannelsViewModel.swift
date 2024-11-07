//
//  ChannelViewModel.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import Foundation
import Firebase
import Combine

class ChannelsViewModel: ObservableObject {
    @Published var channels = [Channel]()
    var channelDocumentReference: DocumentReference?
    
    init() {
        fetchChannels()
    }
    
    func fetchChannels() {
        COLLECTION_CHANNELS.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges else { return }
            
            for change in changes {
                if let channel = try? change.document.data(as: Channel.self),
                   channel.userIds.contains(AuthViewModel.shared.userSession!.uid) {
                    
                    switch change.type {
                    case .added:
                        self.channels.append(channel)
                        
                    case .modified:
                        if let index = self.channels.firstIndex(where: { $0.id == channel.id }) {
                            self.channels[index] = channel
                        } else {
                            self.channels.append(channel)
                        }
                        
                    case .removed:
                        if let index = self.channels.firstIndex(where: { $0.id == channel.id }) {
                            self.channels.remove(at: index)
                        }
                    }
                }
            }
            
            self.channels.sort { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
        }
    }

}
