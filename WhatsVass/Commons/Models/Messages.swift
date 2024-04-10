//
//  Messages.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import Foundation

struct MessageViewResponse: Codable {
    var id, chat, source, nick, avatar, message, date: String
}

struct ChatMessage: Codable {
    var count: Int
    var rows: [RowMessage]
}

struct RowMessage: Codable, Identifiable, Equatable {
    var id, chat, source, message, date: String
}

struct NewMessage: Codable {
    var chat, source, message: String
}

struct NewMessageResponse: Codable {
    var success: Bool
}
