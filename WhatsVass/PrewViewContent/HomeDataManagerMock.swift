//
//  HomeDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import Foundation

final class HomeDataManagerMock: HomeDataManagerProtocol {
    func getChats() async throws -> ChatsList {
        try Bundle.decode(type: ChatsList.self, from: "ChatList")
    }
    
    func getMessages() async throws -> [MessageViewResponse] {
      try Bundle.decode(type: [MessageViewResponse].self, from: "messages")
    }
    
    func deleteChat(chatId: String) async throws -> DeleteChatResponse {
       try Bundle.decode(type: DeleteChatResponse.self, from: "response")
    }
}
