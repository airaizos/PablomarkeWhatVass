//
//  ChatView.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.theme) private var theme: Theme
    // MARK: - Properties
    @ObservedObject var viewModel: ChatViewModel
    @State private var scrollToFirstMessage = true
    @State private var cellCount: Int = 0
    
    var body: some View {
        VStack {
            ScrollViewReader { value in
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.chats) { message in
                            MessageRow(row: message)
                                .frame(maxWidth: .infinity, alignment: message.isMine ? .trailing : .leading)
                                .onAppear {
                                    //  moveScroll(maxCell: viewModel.chats.count)
                                    //   if scrollToFirstMessage {
                                    value.scrollTo(viewModel.lastChatId)
                                    // }
                                    Task {
                                       await viewModel.getMoreMessages(message: message)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                  
                }
            }
          
            .opacity(viewModel.isChatsEmpty ? 0 : 1)
            .overlay {
                Text("No messages")
                    .foregroundColor(.gray)
                    .padding()
                    .opacity(viewModel.isChatsEmpty ? 1 : 0)
            }
         //   .animation(.easeIn, value: viewModel.isChatsEmpty)
            // MARK: - NavBar -
            .navigationBarItems(leading:
                                    UserInitialCircleStatusIndicator(user: viewModel.sourceData)
            )
            .navigationBarTitle(Text(viewModel.name),
                                displayMode: .inline)
            MessageSenderView(viewModel: viewModel)
                .padding([.leading,
                          .trailing])
        }
        // MARK: - Life cycle -
        .onAppear {
            self.cellCount = 0
            Task {
                await viewModel.getChatList(chat: viewModel.chat.chat)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    // MARK: - Public methods -
//    mutating func set(viewModel: ChatViewModel) {
//        self.viewModel = viewModel
//    }
    
    //    func moveScroll(maxCell: Int) {
    //        if self.cellCount == maxCell {
    //            scrollToFirstMessage = false
    //        }
    //        self.cellCount += 1
    //    }
}

#Preview {
    NavigationStack {
        ChatView(viewModel: .preview)
    }
}
