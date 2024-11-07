//
//  NewChannelView.swift
//  Whatsapp
//
//  Created by Emile Billeh on 28/05/2024.
//

import SwiftUI

struct NewChannelView: View {
    @State private var channelName = ""
    @State private var showPicker = false
    @State private var image: UIImage?
    @State private var searchText = ""
    @State private var isEditing = false
    @ObservedObject var viewModel = NewChannelViewModel()
    @Environment(\.presentationMode) var mode
    @Binding var showChatView: Bool
    @Binding var channel: Channel?

    var body: some View {
        VStack {
            HStack {
                Button {
                    showPicker.toggle()
                } label: {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color(.systemGray))
                            Image(systemName: "person.3")
                                .foregroundColor(.white)
                        }
                    }
                }
                .fullScreenCover(isPresented: $showPicker, content: {
                    ImagePicker(showPicker: $showPicker, image: $image, sourceType: .photoLibrary)
                })
                
                TextField("Channel Name", text: $channelName)
                    .padding()
            }
            
            Divider()
            
            SearchBar(text: $viewModel.searchText, isEditing: $isEditing)
                .onTapGesture { isEditing.toggle() }
                .padding()

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.searchableUsers) { user in
                        Button(action: {
                            if viewModel.selectedUsers.contains(where: { $0.id == user.id }) {
                                viewModel.selectedUsers.removeAll { $0.id == user.id }
                            } else {
                                viewModel.selectedUsers.append(user)
                            }
                        }, label: {
                            UserCell(user: user)
                                .background(viewModel.selectedUsers.contains(where: { $0.id == user.id }) ? Color.blue.opacity(0.2) : Color.clear)
                                .cornerRadius(20)
                        })
                    }
                }
            }

            Button(action: {
                if let image = image {
                    viewModel.createChannel(name: channelName, image) { newChannel in
                        if let newChannel = newChannel {
                            self.channel = newChannel
                            self.showChatView = true
                            mode.wrappedValue.dismiss()
                        }
                    }
                } else {
                    viewModel.createChannel(name: channelName) { newChannel in
                        if let newChannel = newChannel {
                            self.channel = newChannel
                            self.showChatView = true
                            mode.wrappedValue.dismiss()
                        }
                    }
                }

            }, label: {
                Text("Create Channel")
                    .bold()
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
            .padding()
        }
        .padding()
    }
}

