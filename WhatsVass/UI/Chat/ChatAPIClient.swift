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
        let url: String = EndpointsMessages.chat //+ "\(chat)?offset=\(first)&limit=\(limit)"

        return requestPublisher(relativePath: url,
                                method: .get)
    }

    func sendMessage(params: [String: Any]) -> AnyPublisher <NewMessageResponse, BaseError> {
        return requestPublisher(relativePath: EndpointsMessages.newMessage,
                                method: .post,
                                parameters: params)
    }
}

protocol ChatAPI {
    func getChatMessagesByAPI(chat: String, first: Int, limit: Int) -> AnyPublisher <ChatMessage, BaseError>
    func sendMessage(params: [String: Any]) -> AnyPublisher <NewMessageResponse, BaseError>
}

