//
//  Message.swift
//  Whatsapp
//
//  Created by Emile Billeh on 27/05/2024.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Decodable {
    @DocumentID var id: String?
    let fromId: String
    let toId: String
    let read: Bool
    let text: String
    let timestamp: Timestamp
    
    var user: User?
    var channel: Channel?
}
