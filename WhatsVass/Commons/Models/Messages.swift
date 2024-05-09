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


extension RowMessage {
    var  isMine: Bool {
        source == UserDefaults.standard.string(forKey: Preferences.id)
    }
    var dateTime: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //TODO: Que se devuelve?
        return dateFormatter.date(from: date) ?? Date.now
    }
}
