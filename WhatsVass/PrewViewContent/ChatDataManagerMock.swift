//
//  ChatDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import Foundation
import Combine

final class ChatDataManagerMock: ChatDataManagerProtocol {
    func getChats(chat: String, first: Int) async throws -> ChatMessage {
        try Bundle.decode(type: ChatMessage.self, from: "getChats")
    }
    
    func sendMessage(params: [String : Any]) async throws -> NewMessageResponse {
        try Bundle.decode(type: NewMessageResponse.self, from: "response")
    }
}
