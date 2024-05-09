//
//  ContactsDataManager.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import Foundation
import Combine

protocol ContactsDataManagerProtocol {
    func getContacts() -> AnyPublisher<[User], BaseError>
    func createChat(source: String, target: String) -> AnyPublisher<ChatCreateResponse, BaseError>
    func getChats() -> AnyPublisher<ChatsList, BaseError>
}

final class ContactsDataManager: ContactsDataManagerProtocol {
    private var apiClient: ContactsAPIClient

    init(apiClient: ContactsAPIClient) {
        self.apiClient = apiClient
    }

    func getContacts() -> AnyPublisher<[User], BaseError> {
        apiClient.getContacts()
    }

    func createChat(source: String, target: String) -> AnyPublisher<ChatCreateResponse, BaseError> {
        return apiClient.createChat(source: source,
                                    target: target)
    }

    func getChats() -> AnyPublisher<ChatsList, BaseError> {
        apiClient.getChats()
    }
}


final class ContactsDataManagerMock: ContactsDataManagerProtocol {
    func getContacts() -> AnyPublisher<[User], BaseError> {
        Bundle.loadJsonPublisher(type: [User].self, from: "getContacts")
    }
    
    func createChat(source: String, target: String) -> AnyPublisher<ChatCreateResponse, BaseError> {
        Bundle.loadJsonPublisher(type: ChatCreateResponse.self, from: "createChat")
    }
    
    func getChats() -> AnyPublisher<ChatsList, BaseError> {
        Bundle.loadJsonPublisher(type: ChatsList.self, from: "ChatList")
    }
}
