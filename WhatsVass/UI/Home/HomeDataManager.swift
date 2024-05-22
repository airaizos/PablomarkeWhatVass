//
//  HomeDataManager.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.
//

import Foundation

protocol HomeDataManagerProtocol {
    func getChats() async throws -> ChatsList
    func getMessages() async throws -> [MessageViewResponse]
    func deleteChat(chatId: String) async throws -> DeleteChatResponse
}


final class HomeDataManager:HomeDataManagerProtocol {
    // MARK: - Properties
    private var apiClient: HomeAPIClient

    // MARK: - Init
    init(apiClient: HomeAPIClient = HomeAPIClient()) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods
    func getChats() async throws -> ChatsList {
       try await apiClient.getChats()
    }
    func getMessages() async throws -> [MessageViewResponse] {
       try await apiClient.getMessages()
    }
    func deleteChat(chatId: String) async throws -> DeleteChatResponse {
       try await apiClient.deleteChat(chatId: chatId)
    }
}
