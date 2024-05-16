//
//  ChatDataManager.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import Foundation

protocol ChatDataManagerProtocol {
    func getChats(chat: String, first: Int) async throws -> ChatMessage
    func sendMessage(params: [String: Any]) async throws -> NewMessageResponse
}

final class ChatDataManager: ChatDataManagerProtocol {
    // MARK: - Properties
    private var apiClient: ChatAPI

    // MARK: - Object lifecycle
    init(apiClient: ChatAPI) {
        self.apiClient = apiClient
    }

    //MARK: Async Await
    func getChats(chat: String, first: Int) async throws -> ChatMessage {
       try await apiClient.getChatMessagesByAPI(chat: chat, first: first, limit: 1)
    }
    
    func sendMessage(params: [String: Any]) async throws -> NewMessageResponse {
        try await apiClient.sendMessage(params: params)
    }
}




