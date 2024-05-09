//
//  Preview+models.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import Foundation
import Combine


extension Chat {
    static let preview = Chat(chat: "1234567890", source: "source_id", sourcenick: "Nombre Origen", sourcetoken:  "source_token", target: "target_id", targetnick: "NombreDestino", targetavatar: "https://api.dicebear.com/8.x/pixel-art-neutral/png", targettoken: "target_token", sourceonline: true, targetonline: false, chatcreated: "2024-04-09T12:00:00Z", lastMessage: "¡Hola! ¿Cómo estás?", lastMessageTime: "2024-05-08T12:00:00Z")
}

extension ChatMessage {
    static let preview = ChatMessage(count: 1, rows: [
            RowMessage(id: "1", chat: "chat 2", source: "Source 1", message: "Message 1", date: "2024-04-25")
    ])
}

final class ChatAPIMock: BaseAPIClient, ChatAPI {
    func getChatMessagesByAPI(chat: String, first: Int, limit: Int) -> AnyPublisher<ChatMessage, BaseError> {
        let chatMessage = ChatMessage.preview
        
        return Just(chatMessage)
            .setFailureType(to: BaseError.self)
                   .eraseToAnyPublisher()
    }
    
    func sendMessage(params: [String : Any]) -> AnyPublisher<NewMessageResponse, BaseError> {
        let result = NewMessageResponse(success: true)
        return Just(result)
            .setFailureType(to: BaseError.self)
                   .eraseToAnyPublisher()
    }
    
    
}
