//
//  ContactsDataManager.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import Foundation

protocol ContactsDataManagerProtocol {
    func getContacts() async throws -> [User]
    func createChat(source: UUID, target: UUID) async throws -> ChatCreateResponse
    func getChats() async throws -> ChatsList
}

final class ContactsDataManager: ContactsDataManagerProtocol {
    private var apiClient: ContactsAPIClient

    init(apiClient: ContactsAPIClient = ContactsAPIClient()) {
        self.apiClient = apiClient
    }
    
    //MARK: Async-Await
    func getContacts() async throws -> [User] {
        try await apiClient.getContacts()
    }
    
    func createChat(source: UUID, target: UUID) async throws -> ChatCreateResponse {
        try await apiClient.createChat(source: source, target: target)
    }
    
    func getChats() async throws -> ChatsList {
        try await apiClient.getChats()
    }
}
