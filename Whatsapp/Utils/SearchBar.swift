//
//  SearchBar.swift
//  Whatsapp
//
//  Created by Emile Billeh on 27/05/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    var body: some View {
        HStack {
            
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                )
            if isEditing {
                Button {
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                }
                .padding(.trailing, 8)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

#Preview {
    SearchBar(text: .constant(""), isEditing: .constant(false))
}
