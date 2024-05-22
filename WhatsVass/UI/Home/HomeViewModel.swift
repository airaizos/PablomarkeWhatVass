//
//  HomeViewModel.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.
//

import Foundation

final class HomeViewModel: ObservableObject, ErrorHandling {
   
    
    // MARK: - Properties -
    @Published var chats: ChatsList = []
    @Published var showingDeleteError: Bool = false
    @Published var deleteErrorMessage: String = ""
    @Published var searchText = ""
    @Published var showContacts = false
    @Published var showSettings = false
    @Published var showNewChat = false
    @Published var newChat: Chat?
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    private var dataManager: HomeDataManagerProtocol
    private var persistence: LocalPersistence

    var filteredChats: ChatsList {
        let myNick = persistence.getString(forKey: Preferences.id) ?? "defaultID"

        let filtered = chats.filter { chat in
            let otherNick = chat.source == myNick ? chat.targetnick : chat.sourcenick
            return searchText.isEmpty ||
                   chat.lastMessage?.lowercased().contains(searchText.lowercased()) ?? false ||
                   otherNick.lowercased().contains(searchText.lowercased())
        }

        return filtered.sorted(by: {
            guard let time1 = $0.lastMessageTime, let time2 = $1.lastMessageTime else { return false }
            return time1 > time2
        })
    }

    init(dataManager: HomeDataManagerProtocol = HomeDataManager(), persistence: LocalPersistence = .shared) {
        self.dataManager = dataManager
        self.persistence = persistence
    }

    // MARK: - Public Methods
    func getChats() {
        Task {
            chats = try await dataManager.getChats()
            updateLastMessages()
        }
    }
    
    func deleteChat(at offsets: IndexSet) {
        offsets.forEach { index in
            let chatId = chats[index].chat
            deleteChat(chatId: chatId)
        }
    }
}

private extension HomeViewModel {
    func deleteChat(chatId: String) {
        Task {
            do {
                let result = try await dataManager.deleteChat(chatId: chatId)
                guard result.success, let index = chats.firstIndex(where: { $0.chat == chatId }) else {
                    showError.toggle()
                    errorMessage = "NoChatDeleted"
                    return
                }
                chats.remove(at: index)
            } catch {
                showErrorMessage(error)
            }
        }
    }

    func updateLastMessages() {
        Task {
            let messages = try await self.dataManager.getMessages()
            let lastMessages = Dictionary(grouping: messages,
                                          by: { $0.chat })
                .mapValues { messages in
                    messages.max(by: { $0.date < $1.date })
                }
            self.chats = chats.map { chat in
                var chat = chat
                if let lastMessage = lastMessages[chat.chat] {
                    chat.lastMessage = lastMessage?.message
                    chat.lastMessageTime = lastMessage?.date
                }
                return chat
            }
        }
    }
}
