//
//  Endpoints.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation

enum Base {
    static let mockMovilidad: String = "https://mock-movilidad.vass.es/chatvass/api/"
}

enum EndpointsUsers {
    static let login: String = "users/login"
    static let logOut: String = "users/logout"
    static let online: String = "users/online/"
    static let register: String = "users/register"
    static let biometric: String = "users/biometric"
    static let users: String = "users"
}

enum EndpointsChats {
    static let chats: String = "chats"
    static let chatsView: String = "chats/view"
    static let createChat: String = "chats"
}

enum EndpointsMessages {
    static let view: String = "messages/view"
    static let chat: String = "messages/list/"
    static let newMessage: String = "messages/new"
}
