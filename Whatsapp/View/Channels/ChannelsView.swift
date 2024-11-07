//
//  ChannelsView.swift
//  SwiftUIChatTutorial
//
//  Created by Stephen Dowless on 5/24/21.
//

import SwiftUI

struct ChannelsView: View {
    @State private var showNewChannelView = false
    @State private var showChatView = false
    @State var selectedChannel: Channel?
    @ObservedObject var viewModel = ChannelsViewModel()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let channel = selectedChannel {
                NavigationLink(
                    destination: ChannelChatView(channel: channel),
                    isActive: $showChatView,
                    label: { })
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.channels) { channel in
                        ChannelCell(viewModel: ChannelCellViewModel(channel))
                    }
                    HStack { Spacer() }
                }
            }

            Button(action: {
                showNewChannelView.toggle()
            }, label: {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $showNewChannelView, content: {
                NewChannelView(showChatView: $showChatView, channel: $selectedChannel)
            })
        }
    }
    
}


struct ChannelsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsView()
    }
}

import SwiftUI
