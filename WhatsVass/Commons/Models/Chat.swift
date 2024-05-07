//
//  Chat.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import Foundation

typealias AllChatResponse = [ChatResponse]

struct ChatResponse: Codable {
    var id, source, target, created: String
}

struct ChatCreate: Codable {
    var source, target: String
}

struct ChatCreateResponse: Codable {
    var success, created: Bool
    var chat: ChatResponse
}

typealias ChatsList = [Chat]

struct Chat: Codable {
    var chat, source, sourcenick: String
    var sourcetoken: String?
    var target, targetnick, targetavatar: String
    var targettoken: String?
    var sourceonline, targetonline: Bool
    var chatcreated: String
    var lastMessage: String?
    var lastMessageTime: String?
}

struct DeleteChatResponse: Codable {
    var success: Bool
}

