//
//  ChannelCell.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import SwiftUI
import Kingfisher

struct ChannelCell: View {
    @ObservedObject var viewModel: ChannelCellViewModel
   
    var body: some View {
        NavigationLink(destination: ChannelChatView(channel: viewModel.channel)) {
            VStack {
                HStack {
                    
                    if viewModel.channel.channelImageUrl != nil {
                        KFImage(viewModel.channelImageUrl)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                    } else {
                        ZStack {
                            Circle()
                                .frame(width: 48, height: 48)
                                .foregroundColor(Color(.systemGray))
                            Image(systemName: "person.3")
                                .foregroundColor(.white)
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 4) {
                        Text(viewModel.channelName)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text(viewModel.lastMessage)
                            .font(.system(size: 15))
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider()
            }
            .padding(.top)
        }
        .id(viewModel.channel.id)
    }
}


