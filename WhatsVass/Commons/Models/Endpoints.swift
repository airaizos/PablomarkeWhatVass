//
//  Endpoints.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation

enum Base {
 //   static let mockMovilidad: String = "https://mock-movilidad.vass.es/chatvass/api/"
    
    static let mock: String = "https://run.mocky.io/v3/"
    static let baseURL: URL = URL(string: "https://run.mocky.io/v3/")!
}

enum EndpointsUsers {
    static let login: String = "52022ddf-d858-42cd-b87c-0f4db569f156" //"users/login"
    static let logOut: String = "0e2b6d17-e83c-4535-8657-949816c60e54" //"users/logout"
    static let online: String = "0e2b6d17-e83c-4535-8657-949816c60e54" //"users/online/"
    static let register: String = "68a151ee-ac5b-4a8d-a69f-168d4f64cfb1"//"users/register"
    static let biometric: String = "62e2639a-576b-4a5b-963a-53d35674bf67" //"users/biometric"
    static let users: String = "4b8542ec-e387-44ed-a542-97895293264a" //"users"
    
    static let urlRegister = Base.baseURL.appending(path: register)
    static let urlUsers = Base.baseURL.appending(path: users)
    static let urlLogout = Base.baseURL.appending(path: logOut)
    static let urlLogin = Base.baseURL.appending(path: login)
    static let urlBiometric = Base.baseURL.appending(path: biometric)
}

enum EndpointsChats {
    static let chats: String = "588cfe52-981a-4b57-9109-e6e6e4c34647" //"chats"
    static let chatsView: String = "9bf79488-8e7d-4bb7-bbc0-49506c4d392d" //"chats/view"
    static let createChat: String = "6823c6a1-214c-4e70-8123-eb828b430207" // "chats"
    
    static let urlChats: URL = Base.baseURL.appending(path: chatsView)
    static let urlDeleteChat: URL =  Base.baseURL.appending(path: chats)
    static let urlCreateChat: URL = Base.baseURL.appending(path: createChat)
}

enum EndpointsMessages {
    static let view: String = "54bdf6fa-3189-494f-9eae-010f2aa3c823" //"messages/view"
    static let chat: String = "9fc6d3ae-2274-4d06-a593-5386672ba2d2"//"messages/list/"
    static let newMessage: String = "68ef2594-e025-4082-a15f-6aa3aa6c0778" //"messages/new"
    
    static let urlView = Base.baseURL.appending(path: view)
    static let urlChat = Base.baseURL.appending(path: chat)
    static let urlNewMessage = Base.baseURL.appending(path: newMessage)
}
