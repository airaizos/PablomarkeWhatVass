//
//  ContactsDataManager.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import Foundation
import Combine

final class ContactsDataManager {
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
