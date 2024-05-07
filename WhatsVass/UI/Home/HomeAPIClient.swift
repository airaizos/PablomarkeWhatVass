//
//  HomeAPIClient.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.
//

import Foundation
import Combine
import Alamofire

final class HomeAPIClient: BaseAPIClient {
    // MARK: - Public methods -
    func getChats() -> AnyPublisher<ChatsList, BaseError> {
        return requestPublisher(relativePath: EndpointsChats.chatsView,
                                method: .get,
                                parameters: nil,
                                urlEncoding: URLEncoding.default,
                                type: ChatsList.self)
    }

    func getMessages() -> AnyPublisher<[MessageViewResponse], BaseError> {
        return requestPublisher(relativePath: EndpointsMessages.view,
                                method: .get,
                                type: [MessageViewResponse].self)
    }

    func deleteChat(chatId: String) -> AnyPublisher<DeleteChatResponse, BaseError> {
        let path = EndpointsChats.chats //+ "/\(chatId)"

        return requestPublisher(relativePath: path,
                                method: .delete,
                                parameters: nil,
                                urlEncoding: URLEncoding.default,
                                type: DeleteChatResponse.self)

    }
}
