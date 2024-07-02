//
//  ContactsAPIClient.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import Foundation

final class ContactsAPIClient: BaseAPIClient {
    func getContacts() async throws -> [User] {
        try await fetchCodable(url: Base.getContacts, type: [User].self)
    }

    func createChat(source: UUID, target: UUID) async throws -> ChatCreateResponse {
        let params = ["source": source, "target": target]
        guard let chat = encodeChat(with: params) else {
            throw BaseError.noCodable
        }
        return try await postCodable(url: Base.createChat, data: chat)
    }
    
    func getChats() async throws -> ChatsList {
       try await fetchCodable(url: EndpointsChats.urlChats, type: ChatsList.self)
    }
    
    private func encodeChat(with params: [String: Any]) -> ChatCreate? {
        guard let source = params["source"] as? UUID,  let target = params["target"] as? UUID else { return nil }
        return ChatCreate(source: source, target: target)
    }
}
