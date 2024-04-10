//
//  HomeDataManager.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.
//

import Foundation
import Combine

final class HomeDataManager {
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
                return deleteChat
            }
            .mapError { error in
                return error as? BaseError ?? .failedChat
            }
            .eraseToAnyPublisher()
    }
}
