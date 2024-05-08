//
//  ChatViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import Foundation
import SwiftUI
import Combine

final class ChatViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var chat: Chat
    private var dataManager: ChatDataManager
    var cancellables: Set<AnyCancellable> = []
    @Published var chats: [RowMessage]?
    @Published var name: String = ""

    init(dataManager: ChatDataManager, chat: Chat) {
        self.dataManager = dataManager
        self.chat = chat
    }

    // MARK: Public Methods
    func getChatList(chat: String, first: Int = 0) {
        
        dataManager.getChats(chat: chat, first: first)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure = completion {
                  // print error
                }
            } receiveValue: { [weak self] messages in
                self?.chats = messages.rows
                let myID = UserDefaults.standard.string(forKey: Preferences.id) ?? "defaultID"
                self?.name = self?.chat.source == myID ? self?.chat.targetnick ?? "" : self?.chat.sourcenick ?? ""
            }.store(in: &cancellables)
    }

    func getMoreMessages(message: RowMessage) {
        if chats?.last == message {
            getPreviousMessages()
        }
    }

    func getPreviousMessages() {
        var nextMessage: Int {
            chats?.count ?? 20
        }
        dataManager.getChats(chat: chat.chat, first: nextMessage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure  = completion {
                    // print(error)
                }
            } receiveValue: { [weak self] messages in
                self?.chats?.append(contentsOf: messages.rows)
            }.store(in: &cancellables)
    }

    func onlineColor() -> Color {
        self.chat.targetonline ? Color.green : Color.red
    }

    func sendNewMessage(message: String) {
        let params: [String: Any] = ["chat": chat.chat,
                                     "source": UserDefaults.standard.string(forKey: Preferences.id) ?? "",
                                     "message": message]
        dataManager.sendMessage(params: params)
            .sink {  completion in
                if case let .failure(error) = completion {
                    print(error.description())
                }
            } receiveValue: { [weak self] _ in
                if let chatId = self?.chat.chat {
                    self?.getChatList(chat: chatId)
                }
            }.store(in: &cancellables)
    }

    func messageIsMine(sentBy: String) -> Bool {
        sentBy == UserDefaults.standard.string(forKey: Preferences.id)
    }
}
