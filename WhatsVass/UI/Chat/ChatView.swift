//
//  ChatView.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import SwiftUI

struct ChatView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: ChatViewModel
    @State private var scrollToFirstMessage = true
    @State private var cellCount: Int = 0

    public init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - View -
    var body: some View {
        VStack {
            VStack {
                ScrollViewReader { value in
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            if let chats = viewModel.chats, !chats.isEmpty {
                                ForEach(chats.reversed()) { message in
                                    MessageRow(message: message.message,
                                               time: message.date.fakeDateToString(),
                                               ownMessage: viewModel.messageIsMine(sentBy: message.source))
                                    .onAppear {
                                        moveScroll(maxCell: chats.count)
                                        if scrollToFirstMessage {
                                            if let firstMessageId = chats.first?.id {
                                                value.scrollTo(firstMessageId)
                                            }
                                        }
                                        viewModel.getMoreMessages(message: message)
                                    }
                                }
                            } else {
                                Text("No messages")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                }
            }

            // MARK: - NavBar -
            .navigationBarItems(leading:
                                    HStack {
                ImageProfileView(onlineColor: viewModel.onlineColor())
            })
            .navigationBarTitle(Text(viewModel.name),
                                displayMode: .inline)
            MessageSenderView(viewModel: viewModel)
                .padding([.leading,
                    .trailing])
        }
        // MARK: - Life cycle -
        .onAppear {
            self.cellCount = 0
            viewModel.getChatList(chat: viewModel.chat.chat)
        }
    }
    // MARK: - Public methods -
    mutating func set(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }

    func moveScroll(maxCell: Int) {
        if self.cellCount == maxCell {
            scrollToFirstMessage = false
        }
        self.cellCount += 1
    }
}
#Preview {
    ChatView(viewModel: ChatViewModel(dataManager: ChatDataManager(apiClient: ChatAPIMock()), chat: Chat.preview))
}
