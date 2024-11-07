//
//  CustomTextField.swift
//  Whatsapp
//
//  Created by Emile Billeh on 27/05/2024.
//

import SwiftUI

struct CustomTextField: View {
    let imageName: String
    let placeholderText: String
    let isSecureField: Bool
    @Binding var text: String
    
    var body: some View {
        VStack (spacing: 16) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

