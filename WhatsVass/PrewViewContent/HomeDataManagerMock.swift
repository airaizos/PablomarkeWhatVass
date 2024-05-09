//
//  HomeDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import Foundation
import Combine

final class HomeDataManagerMock: HomeDataManagerProtocol {
    func getChats() -> AnyPublisher<ChatsList, BaseError> {
        Bundle.loadJsonPublisher(type: [Chat].self, from: "ChatList")
    }
    
    func getMessages() -> AnyPublisher<[MessageViewResponse], BaseError> {
        Bundle.loadJsonPublisher(type: [MessageViewResponse].self, from: "messages")
    }
    
    func deleteChat(chatId: String) -> AnyPublisher<DeleteChatResponse, BaseError> {
        Bundle.loadJsonPublisher(type: DeleteChatResponse.self, from: "response")
    }
}
