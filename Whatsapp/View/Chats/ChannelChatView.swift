//
//  ChannelChatView.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import SwiftUI

struct ChannelChatView: View {
    @State private var messageText = ""
    @ObservedObject var viewModel: ChannelChatViewModel
    private let channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
        self.viewModel = ChannelChatViewModel(channel: channel)
    }
    
    @State private var scrollViewID = UUID()

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                ChannelMessageView(viewModel: ChannelMessageViewModel(message: message))
                                    .id(message.id) // Add id to each message view
                            }
                        }
                        .rotationEffect(.degrees(180))
                        .frame(width: geometry.size.width)
                    }
                    .rotationEffect(.degrees(180))
                }
            }

            CustomInputView(text: $messageText, action: sendMessage)
        }
        .navigationTitle(channel.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func sendMessage() {
        if messageText == "" {
            return
        } else {
            viewModel.sendMessage(messageText)
            messageText = ""
        }
    }
}

