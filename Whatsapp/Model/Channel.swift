//
//  Channel.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import Firebase
import FirebaseFirestoreSwift

struct Channel: Identifiable, Decodable {
    @DocumentID var id: String?
    let name: String
    let userIds: [String]
    let lastMessage: String
    let timestamp: Timestamp
    let channelImageUrl: String?
}
