//
//  UserCell.swift
//  SwiftUIChatTutorial
//
//  Created by Stephen Dowless on 5/25/21.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    
    var body: some View {
        VStack {
            HStack {
                
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                // message info
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.username)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(user.fullname)
                        .font(.system(size: 15))
                }
                .foregroundColor(.black)
                
                Spacer()
                
            }
            .padding(.horizontal, 8)
            }
        .padding(.vertical, 8)
    }
}
