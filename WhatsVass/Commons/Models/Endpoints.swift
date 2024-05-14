//
//  Endpoints.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation

enum Base {
 //   static let mockMovilidad: String = "https://mock-movilidad.vass.es/chatvass/api/"
    
  //  static let mock: String = "https://run.mocky.io/v3/"
    static let baseURL: URL = URL(string: "https://run.mocky.io/v3/")!
}

enum EndpointsUsers {
    static let login: String = "f380a68e-676f-4c8f-8d7a-479b9db32ee2" //"users/login //loginResponse"
    static let logOut: String = "3c35da26-67f5-468e-9df5-841491b7312a" //"users/logout" //logoutResponse
    static let online: String = "0e2b6d17-e83c-4535-8657-949816c60e54" //"users/online/"
    static let register: String = "3c35da26-67f5-468e-9df5-841491b7312a"//"users/register" //logoutResponse
    static let biometric: String = "62e2639a-576b-4a5b-963a-53d35674bf67" //"users/biometric"
    static let users: String = "4f81b431-e058-438d-ad56-da33b70828fe" //"users" //getContacts
    
    static let urlRegister = Base.baseURL.appending(path: register)
    static let urlUsers = Base.baseURL.appending(path: users)
    static let urlLogout = Base.baseURL.appending(path: logOut)
    static let urlLogin = Base.baseURL.appending(path: login)
    static let urlBiometric = Base.baseURL.appending(path: biometric)
}

enum EndpointsChats {
    static let chats: String = "3eb0304d-b3ce-4619-8c8f-fe786be3a2fe" //"chats" //Response
    static let chatsView: String = "0b9da98f-ebec-446a-8231-307b236f3bcf" //"chats/view" //GetChats
    static let createChat: String = "68e19a97-52ee-4c98-87ef-5d07740cbafe" // "chats" //creteChat
    
    static let urlChats: URL = Base.baseURL.appending(path: chatsView)
    static let urlDeleteChat: URL =  Base.baseURL.appending(path: chats)
    static let urlCreateChat: URL = Base.baseURL.appending(path: createChat)
}

enum EndpointsMessages {
    static let view: String = "e8e28d23-31ba-4328-98ae-b9b7faf7753f" //"messages/view" //messages
    static let chat: String = "0b9da98f-ebec-446a-8231-307b236f3bcf"//"messages/list/" //chatlist
    static let newMessage: String = "3eb0304d-b3ce-4619-8c8f-fe786be3a2fe" //"messages/new" //response
    
    static let urlView = Base.baseURL.appending(path: view)
    static let urlChat = Base.baseURL.appending(path: chat)
    static let urlNewMessage = Base.baseURL.appending(path: newMessage)
}
