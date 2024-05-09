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

extension Chat {
    //Chat Row
    var showLasMesageDateInfo: String {
        guard let lastMessageTime else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let messageDate = dateFormatter.date(from: lastMessageTime) else { return "" }
        return messageDate.messageDateView
    }
    
    private var myID:String {
        UserDefaults.standard.string(forKey: Preferences.id) ?? "defaultID"
    }
    
    var isOtherUserOnline: Bool {
        source == myID ? targetonline : sourceonline
    }

    var otherUserNick: String {
        source == myID ? targetnick : sourcenick
    }
    
    var lastMessageView: String {
        lastMessage ?? ""
    }
}


let calendar = Calendar.current

extension Date {
    var messageDateView: String {
        if calendar.isDateInToday(self) {
            return self.formatted(date: .omitted, time: .shortened)
        } else if calendar.isDateInYesterday(self) {
            return "Ayer"
        } else {
            return self.formatted(date: .numeric, time: .omitted)
        }
    }
}
