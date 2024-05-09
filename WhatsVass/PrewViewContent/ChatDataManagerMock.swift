//
//  ChatDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import Foundation
import Combine

final class ChatDataManagerMock: ChatDataManagerProtocol {
    func getChats(chat: String, first: Int) -> AnyPublisher<ChatMessage, BaseError> {
        Bundle.loadJsonPublisher(type: ChatMessage.self, from: "getChats")
    }
    
    func sendMessage(params: [String : Any]) -> AnyPublisher<NewMessageResponse, BaseError> {
        Bundle.loadJsonPublisher(type: NewMessageResponse.self, from: "response")
    }
}
