//
//  ChatAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import Foundation

final class ChatAPIClient: BaseAPIClient, ChatAPI {
    
    //MARK: AsyncAwait
    func getChatMessagesByAPI(chat: String, first: Int, limit: Int = 20) async throws -> ChatMessage {
       try await fetchCodable(url: EndpointsMessages.urlChat, type: ChatMessage.self)
    }
    func sendMessage(params: [String: Any]) async throws -> NewMessageResponse {
        let data = try encodeMessage(with: params)
        return try await postCodable(url: EndpointsMessages.urlNewMessage, data: data)
    }
    
    
    // MARK: Private methods
    private func encodeMessage(with params: [String: Any]) throws -> Data {
        guard let chat = params["chat"] as? String, let source = params["source"] as? String, let message = params["message"] as? String else {
            throw BaseError.noCodable
        }
        let newMessage = NewMessage(chat: chat, source: source, message: message)
        guard let data = try? JSONEncoder().encode(newMessage) else {
        throw BaseError.noCodable
        }
        return data
    }
    }

protocol ChatAPI {
    
    func getChatMessagesByAPI(chat: String, first: Int, limit: Int) async throws -> ChatMessage
    func sendMessage(params: [String: Any]) async throws -> NewMessageResponse
}

