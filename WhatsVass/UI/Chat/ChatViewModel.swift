//
//  ChatViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import Foundation
import SwiftUI

final class ChatViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var chat: Chat
    private var dataManager: ChatDataManagerProtocol
    private var persistence: LocalPersistence
    private var myId: String
    @Published var chats: [RowMessage] = []
    @Published var name: String = ""
    
    @Published var showError = false
    @Published var errorMessage = ""

    init(dataManager: ChatDataManagerProtocol = ChatDataManager(), chat: Chat, persistence: LocalPersistence = .shared) {
        self.dataManager = dataManager
        self.chat = chat
        self.persistence = persistence
        myId = persistence.getString(forKey: .id) ?? "defaultID"
    }

    // MARK: ChatView
    
    var isChatsEmpty: Bool {
        chats.isEmpty
    }
    
    var lastChatId: String {
            chats.last?.id ?? ""
        }
    
    @MainActor
    func getChatList(chat: String, first: Int = 0) async {
        do {
            chats = try await dataManager.getChats(chat: chat, first: first).rows
            name = self.chat.source == myId ? self.chat.targetnick : self.chat.sourcenick
        } catch {
            showErrorMessage(error)
        }
    }

    func getMoreMessages(message: RowMessage) async {
        if chats.last == message {
           await getPreviousMessages()
        }
    }

    func getPreviousMessages() async {
        var nextMessage: Int {
            chats.count
        }
       
        // FIXME:  se duplican al venir de un mock
        do {
             let newMessages = try await dataManager.getChats(chat: chat.chat, first: nextMessage).rows
            //chats?.append(contentsOf: newMessages)
        } catch {
            showErrorMessage(error)
        }
    }
    
    func onlineColor() -> Color {
        self.chat.targetonline ? Color.green : Color.red
    }
    
    var sourceData: User {
        User(id: chat.target, nickname: chat.targetnick, avatar: chat.targetavatar, onLine: chat.targetonline)
    }
    
    func sendNewMessage(message: String) async {
        let params: [String: Any] = ["chat": chat.chat,
                                     "source": persistence.getString(forKey: Preferences.id) ?? "601",
                                     "message": message]
        do {
            let response = try await dataManager.sendMessage(params: params)
            await getChatList(chat: chat.chat)
        } catch {
            showErrorMessage(error)
        }
    }

    func messageIsMine(sentBy: String) -> Bool {
        sentBy == myId
    }
    
    //MARK: - Private methods -
    private func showErrorMessage(_ error: Error) {
        showError.toggle()
        if let error = error as? BaseError {
            errorMessage = error.description()
        } else {
            errorMessage = "There has been a error"
        }
    }
}
