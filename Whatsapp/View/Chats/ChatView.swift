//
//  ChatView.swift
//  SwiftUIChatTutorial
//
//  Created by Stephen Dowless on 5/24/21.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    @ObservedObject var viewModel: ChatViewModel
    private let user: User
    @State private var lastMessageString: String?
    
    init(user: User) {
        self.user = user
        self.viewModel = ChatViewModel(user: user)
    }
    
    @State private var scrollViewID = UUID()

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                MessageView(viewModel: MessageViewModel(message: message))
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
        .navigationTitle(viewModel.user.username)
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


