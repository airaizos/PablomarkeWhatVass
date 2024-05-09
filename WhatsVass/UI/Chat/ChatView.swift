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

    var body: some View {
        VStack {
            VStack {
                ScrollViewReader { value in
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            if let chats = viewModel.chats, !chats.isEmpty {
                                ForEach(chats) { message in
                                    MessageRow(row: message)
                                    .frame(maxWidth: .infinity, alignment: message.isMine ? .trailing : .leading)
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
                        .padding()
                    }
                }
            }

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
    NavigationStack {
        ChatView(viewModel: ChatViewModel(dataManager: ChatDataManagerMock(), chat: Chat.preview))
    }
}
