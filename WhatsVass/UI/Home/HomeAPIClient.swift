//
//  HomeAPIClient.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.
//

import Foundation

final class HomeAPIClient: BaseAPIClient {
    // MARK: - Public methods -
    
    // TODO: Habrá que pasarle el source id,
    func getChats() async throws -> ChatsList {
        try await fetchCodable(url: EndpointsChats.urlChats, type: ChatsList.self)
    }
    
    func getMessages() async throws -> [MessageViewResponse] {
        try await fetchCodable(url: EndpointsMessages.urlMessages, type: [MessageViewResponse].self)
    }
    
    func deleteChat(chatId: String) async throws -> DeleteChatResponse {
        try await fetchCodable(url: EndpointsChats.urlDeleteChat, type: DeleteChatResponse.self)
    }
    
}
