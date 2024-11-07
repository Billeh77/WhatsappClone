//
//  ChannelMessageView.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import SwiftUI
import Kingfisher

struct ChannelMessageView: View {
    let viewModel: ChannelMessageViewModel
    
    var body: some View {
        HStack {
            if viewModel.isFromCurrentUser {
                Spacer()
                
                Text(viewModel.message.text)
                    .padding(12)
                    .background(Color.blue)
                    .font(.system(size: 15))
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.leading, 100)
                    .padding(.horizontal)
                
            } else {
                HStack(alignment: .bottom) {
                    VStack {
                        if let name = viewModel.message.user?.fullname {
                            Text(getFirstName(fullName: name))
                                .font(.system(size: 10))
                                .foregroundColor(Color(.placeholderText))
                                .padding(.bottom, -5)
                        } else {
                            
                        }
                        KFImage(viewModel.profileImageUrl)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    }
                    
                    Text(viewModel.message.text)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .font(.system(size: 15))
                        .clipShape(ChatBubble(isFromCurrentUser: false))
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .padding(.trailing, 80)
                
                Spacer()
            }
        }
    }
    
    func getFirstName(fullName: String) -> String {
        // Split the string by spaces
        let nameParts = fullName.split(separator: " ")
        
        // Return the first part as the first name
        return nameParts.first.map { String($0) } ?? fullName
    }
}
