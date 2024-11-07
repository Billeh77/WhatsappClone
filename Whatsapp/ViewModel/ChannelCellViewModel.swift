//
//  ChannelCellViewModel.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import SwiftUI

class ChannelCellViewModel: ObservableObject {
    @Published var channel: Channel

    init(_ channel: Channel) {
        self.channel = channel
    }

    var channelName: String {
        return channel.name
    }

    var lastMessage: String {
        return channel.lastMessage
    }
    
    var channelImageUrl: URL? {
        guard let channelImageUrl = channel.channelImageUrl else { return nil }
        return URL(string: channelImageUrl)
    }
}

