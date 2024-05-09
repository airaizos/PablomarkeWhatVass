//
//  HomeDataManager.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.
//

import Foundation
import Combine

protocol HomeDataManagerProtocol {
    func getChats() -> AnyPublisher<ChatsList, BaseError>
    func getMessages() -> AnyPublisher<[MessageViewResponse], BaseError>
    func deleteChat(chatId: String) -> AnyPublisher<DeleteChatResponse, BaseError>
}


final class HomeDataManager:HomeDataManagerProtocol {
    // MARK: - Properties
    private var apiClient: HomeAPIClient
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(apiClient: HomeAPIClient) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods
    func getChats() -> AnyPublisher<ChatsList, BaseError> {
        apiClient.getChats()
            .tryMap { chats in
                //saveCodableToDocumentsDirectory(chats, fileName: "ChatList.json")
                return chats
            }
            .mapError { error in
                return error as? BaseError ?? .failedChat
            }
            .eraseToAnyPublisher()
    }

    func getMessages() -> AnyPublisher<[MessageViewResponse], BaseError> {
        apiClient.getMessages()
            .tryMap { messages in
                //saveCodableToDocumentsDirectory(messages, fileName: "MessageViewResponse.json")
                return messages
            }
            .mapError { error in
                return error as? BaseError ?? .failedChat
            }
            .eraseToAnyPublisher()
    }

    func deleteChat(chatId: String) -> AnyPublisher<DeleteChatResponse, BaseError> {
        return apiClient.deleteChat(chatId: chatId)
            .tryMap { deleteChat in
                //saveCodableToDocumentsDirectory(deleteChat,fileName: "deleteChat.json")
                return deleteChat
            }
            .mapError { error in
                return error as? BaseError ?? .failedChat
            }
            .eraseToAnyPublisher()
    }
}
