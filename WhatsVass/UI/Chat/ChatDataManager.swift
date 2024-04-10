//
//  ChatDataManager.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import Foundation
import Combine

final class ChatDataManager {
    // MARK: - Properties
    private var apiClient: ChatAPIClient
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Object lifecycle
    init(apiClient: ChatAPIClient) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods
    func getChats(chat: String, first: Int) -> AnyPublisher <ChatMessage, BaseError> {
        apiClient.getChatMessagesByAPI(chat: chat, first: first)
            .tryMap { messages in
                return messages
            }
            .mapError { error in
                return error as? BaseError ?? .generic
            }
            .eraseToAnyPublisher()
    }

    func sendMessage(params: [String: Any]) -> AnyPublisher <NewMessageResponse, BaseError> {
        apiClient.sendMessage(params: params)
            .tryMap { newMessageResponse in
                return newMessageResponse
            }
            .mapError { error in
                return error as? BaseError ?? .generic
            }
            .eraseToAnyPublisher()
    }
}
