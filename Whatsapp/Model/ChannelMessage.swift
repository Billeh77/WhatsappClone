//
//  ChannelMessage.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct ChannelMessage: Identifiable, Decodable {
    @DocumentID var id: String?
    let channelId: String
    let fromId: String
    let read: Bool
    let text: String
    let timestamp: Timestamp
    
    var user: User?
    var channel: Channel?
}
