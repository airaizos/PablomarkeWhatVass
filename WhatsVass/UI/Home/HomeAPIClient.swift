//
//  HomeAPIClient.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.
//

import Foundation
import Combine

final class HomeAPIClient: BaseAPIClient {
    // MARK: - Public methods -
    func getChats() -> AnyPublisher<ChatsList, BaseError> {
        requestPublisher(url: EndpointsChats.urlChats,type: ChatsList.self)
    }
    
    func getMessages() -> AnyPublisher<[MessageViewResponse], BaseError> {
          requestPublisher(url: EndpointsMessages.urlView, type: [MessageViewResponse].self)
    }
    
    func deleteChat(chatId: String) -> AnyPublisher<DeleteChatResponse, BaseError> {
        requestPublisher(url: EndpointsChats.urlDeleteChat, method: .get, type: DeleteChatResponse.self)
    }
}
