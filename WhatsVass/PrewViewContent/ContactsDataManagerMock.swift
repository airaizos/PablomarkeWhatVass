//
//  ContactsDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 15/5/24.
//

import Foundation
import Combine

final class ContactsDataManagerMock: ContactsDataManagerProtocol {
    //MARK: Async
    func getContacts() async throws -> [User] {
       try Bundle.decode(type: [User].self, from: "getContacts")
    }
    
    func createChat(source: String, target: String) async throws -> ChatCreateResponse {
        try Bundle.decode(type: ChatCreateResponse.self, from: "createChat")
    }
    
    func getChats() async throws -> ChatsList {
        try Bundle.decode(type: ChatsList.self, from: "ChatList")
    }
    
    //MARK: Combine
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
