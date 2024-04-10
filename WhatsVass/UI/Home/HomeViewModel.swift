//
//  HomeViewModel.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var chats: ChatsList = []
    @Published var showingDeleteError: Bool = false
    @Published var deleteErrorMessage: String = ""
    @Published var searchText = ""

    private var dataManager: HomeDataManager
    private var cancellables = Set<AnyCancellable>()

    let newChatSelectedSubject = PassthroughSubject<Void, Never>()
    var navigateToChatSubject = PassthroughSubject<Chat, Never>()
    var navigateToProfileSubject = PassthroughSubject<Void, Never>()
    var navigateToSettingsSubject = PassthroughSubject<Void, Never>()
    var filteredChats: ChatsList {
        let myNick = UserDefaults.standard.string(forKey: Preferences.id) ?? "defaultID"

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

    init(dataManager: HomeDataManager) {
        self.dataManager = dataManager
    }

    // MARK: - Public Methods
    func getChats() {
        dataManager.getChats()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print(error.description())
                }
            } receiveValue: { [weak self] chat in
                self?.chats = chat
                self?.updateLastMessages()
            }.store(in: &cancellables)
    }

    func deleteChat(at offsets: IndexSet) {
        offsets.forEach { index in
            let chatId = chats[index].chat
            deleteChat(chatId: chatId)
        }
    }

    // MARK: - Navigation
    func onChatSelected(_ chat: Chat) {
        navigateToChatSubject.send(chat)
    }

    func onNewChatSelected() {
        newChatSelectedSubject.send(())
    }

    func navigateToProfile() {
        navigateToProfileSubject.send()
    }

    func navigateToSettings() {
        navigateToSettingsSubject.send()
    }
}

private extension HomeViewModel {
    func deleteChat(chatId: String) {
        dataManager.deleteChat(chatId: chatId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completionStatus in
                guard case .failure(let error) = completionStatus else { return }

                self?.showingDeleteError = true
                self?.deleteErrorMessage = NSLocalizedString("NoChatDeleted",
                                                             comment: "")
            }, receiveValue: { [weak self] success in
                guard success.success, let index = self?.chats.firstIndex(where: { $0.chat == chatId }) else {
                    self?.showingDeleteError = true
                    return
                }
                self?.chats.remove(at: index)
            })
            .store(in: &cancellables)
    }

    func updateLastMessages() {
        dataManager.getMessages()
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    print(error.description())
                }
            }, receiveValue: { [weak self] messages in
                let lastMessages = Dictionary(grouping: messages,
                                              by: { $0.chat })
                    .mapValues { messages in
                        messages.max(by: { $0.date < $1.date })
                    }
                self?.chats = self?.chats.map { chat in
                    var chat = chat
                    if let lastMessage = lastMessages[chat.chat] {
                        chat.lastMessage = lastMessage?.message
                        chat.lastMessageTime = lastMessage?.date
                    }
                    return chat
                } ?? []
            })
            .store(in: &cancellables)
    }
}
