//
//  ContactsAPIClient.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import Foundation
import Alamofire
import Combine

final class ContactsAPIClient: BaseAPIClient {
    func getContacts() -> AnyPublisher<[User], BaseError> {
        requestPublisher(relativePath: EndpointsUsers.users,
                         method: .get,
                         parameters: nil,
                         urlEncoding: URLEncoding.default,
                         type: [User].self)
    }

    func createChat(source: String, target: String) -> AnyPublisher<ChatCreateResponse, BaseError> {
        let parameters: Parameters = ["source": source,
                                      "target": target]
        return requestPublisher(relativePath: EndpointsChats.createChat,
                                method: .post,
                                parameters: parameters,
                                urlEncoding: JSONEncoding.default,
                                type: ChatCreateResponse.self)
    }

    func getChats() -> AnyPublisher<ChatsList, BaseError> {
        return requestPublisher(relativePath: EndpointsChats.chatsView,
                                method: .get,
                                parameters: nil,
                                urlEncoding: URLEncoding.default,
                                type: ChatsList.self)
    }
}
