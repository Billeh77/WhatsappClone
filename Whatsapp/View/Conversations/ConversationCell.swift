//
//  UserCell.swift
//  SwiftUIChatTutorial
//
//  Created by Stephen Dowless on 5/25/21.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    @ObservedObject var viewModel: ConversationCellViewModel
    
    var body: some View {
        if let user = viewModel.message.user {
            NavigationLink(destination: ChatView(user: user)) {
                VStack {
                    HStack {
                        
                        KFImage(viewModel.chatPartnerProfileImageUrl)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                        
                        // message info
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.fullname)
                                .font(.system(size: 14, weight: .semibold))
                            
                            Text(viewModel.message.text)
                                .font(.system(size: 15))
                                .lineLimit(1) // Limit to one line
                                .truncationMode(.tail) 
                        }.foregroundColor(.black)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                    Divider()
                }
                .padding(.top)
            }
        }
    }
}
