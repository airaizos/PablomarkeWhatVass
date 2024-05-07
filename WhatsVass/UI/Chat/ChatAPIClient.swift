//
//  ChatAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import Foundation
import Combine

final class ChatAPIClient: BaseAPIClient, ChatAPI {
    func getChatMessagesByAPI(chat: String, first: Int, limit: Int = 20) -> AnyPublisher <ChatMessage, BaseError> {
      requestPublisher(url: EndpointsMessages.urlChat, type: ChatMessage.self)
    }

    func sendMessage(params: [String: Any]) -> AnyPublisher <NewMessageResponse, BaseError> {
        guard let data = encodeMessage(with: params) else {
            return Fail(error: BaseError.noCodable).eraseToAnyPublisher()
        }
       return requestPostPublisher(url: EndpointsMessages.urlNewMessage, data: data)
    }
    
    private func encodeMessage(with params: [String: Any]) -> Data? {
        guard let chat = params["chat"] as? String, let source = params["source"] as? String, let message = params["message"] as? String else {
            return nil
        }
        let newMessage = NewMessage(chat: chat, source: source, message: message)
        guard let data = try? JSONEncoder().encode(newMessage) else { return nil }
        return data
    }
}

protocol ChatAPI {
    func getChatMessagesByAPI(chat: String, first: Int, limit: Int) -> AnyPublisher <ChatMessage, BaseError>
    func sendMessage(params: [String: Any]) -> AnyPublisher <NewMessageResponse, BaseError>
}

