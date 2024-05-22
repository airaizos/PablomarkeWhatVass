//
//  ContactsAPIClient.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import Foundation

final class ContactsAPIClient: BaseAPIClient {
    func getContacts() async throws -> [User] {
        try await fetchCodable(url: EndpointsUsers.urlUsers, type: [User].self)
    }

    func createChat(source: String, target: String) async throws -> ChatCreateResponse {
        let params = ["source": source, "target": target]
        guard let chat = encodeChat(with: params) else {
            throw BaseError.noCodable
        }
        return try await postCodable(url: EndpointsChats.urlCreateChat, data: chat)
    }
    
    func getChats() async throws -> ChatsList {
       try await fetchCodable(url: EndpointsChats.urlChats, type: ChatsList.self)
    }
    
    private func encodeChat(with params: [String: Any]) -> Data? {
        guard let source = params["source"] as? String,  let target = params["target"] as? String else { return nil }

        let chat = ChatCreate(source: source, target: target)
        guard let data = try? JSONEncoder().encode(chat) else { return nil }
        return data
        
    }
}
