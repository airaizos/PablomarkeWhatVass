//
//  ContactsDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 15/5/24.
//

import Foundation

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
}
