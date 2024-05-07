//
//  ContactsAPIClient.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import Foundation
import Combine

final class ContactsAPIClient: BaseAPIClient {
    func getContacts() -> AnyPublisher<[User], BaseError> {
        requestPublisher(url: EndpointsUsers.urlUsers, type: [User].self)
    }

    func createChat(source: String, target: String) -> AnyPublisher<ChatCreateResponse, BaseError> {
        let params = ["source": source, "target": target]
        guard let chat = encodeChat(with: params) else {
            return Fail(error: BaseError.noCodable).eraseToAnyPublisher()
        }
        return requestPostPublisher(url: EndpointsChats.urlCreateChat, data: chat)
    }

    func getChats() -> AnyPublisher<ChatsList, BaseError> {
        requestPublisher(url: EndpointsChats.urlChats, type: ChatsList.self)
    }
    
    private func encodeChat(with params: [String: Any]) -> Data? {
        guard let source = params["source"] as? String,  let target = params["target"] as? String else { return nil }

        let chat = ChatCreate(source: source, target: target)
        guard let data = try? JSONEncoder().encode(chat) else { return nil }
        return data
        
    }
}
