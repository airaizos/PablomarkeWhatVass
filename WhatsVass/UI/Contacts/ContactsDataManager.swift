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
    
    func getContacts() async throws -> [User]
    func createChat(source: String, target: String) async throws -> ChatCreateResponse
    func getChats() async throws -> ChatsList 
}

final class ContactsDataManager: ContactsDataManagerProtocol {
    private var apiClient: ContactsAPIClient

    init(apiClient: ContactsAPIClient) {
        self.apiClient = apiClient
    }

    //MARK: Combine
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
    
    //MARK: Async-Await
    func getContacts() async throws -> [User] {
        try await apiClient.getContacts()
    }
    
    func createChat(source: String, target: String) async throws -> ChatCreateResponse {
        try await apiClient.createChat(source: source, target: target)
    }
    
    func getChats() async throws -> ChatsList {
        try await apiClient.getChats()
    }
}
