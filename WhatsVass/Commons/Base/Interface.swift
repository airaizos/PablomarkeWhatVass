//
//  Interface.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 25/4/24.
//

import Foundation

protocol URLPointsProtocol {
    static var baseURL: URL { get }
  
}

struct Endpoints:URLPointsProtocol {
    static let baseURL = URL(string: "https://mock-movilidad.vass.es/chatvass/api/")!

    struct Users {
        static let users = baseURL.appending(component: "users")
        static let login = users.appending(component: "login")
        static let logout = users.appending(component: "logout")
        static let online = users.appending(component: "online")
        static let register = users.appending(component:"register")
        static let biometric = users.appending(component: "biometric")
    }
    
    struct Chats {
        static let chats = baseURL.appending(component: "chats")
        static let chatsView = chats.appending(component: "view")
        static let createChat = chats
    }
    
    struct Messages {
        private static let messages = baseURL.appending(component: "messages")
        static let view = messages.appending(component: "view")
        static let chat = messages.appending(component: "list")
        static let newMessaage = messages.appending(component: "new")
    }
}
