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
    static let register: String = "26877e6c-68c4-4b1c-a051-46bbddea8f6d"//"users/register" //createAndRegisterProfile
    static let biometric: String = "f380a68e-676f-4c8f-8d7a-479b9db32ee2" //"users/biometric" //
    static let users: String = "4f81b431-e058-438d-ad56-da33b70828fe" //"users" //getContacts
    
    static let urlRegister = Base.baseURL.appending(path: register)
    static let urlUsers = Base.baseURL.appending(path: users)
    static let urlLogout = Base.baseURL.appending(path: logOut)
    static let urlLogin = Base.baseURL.appending(path: login)
    static let urlBiometric = Base.baseURL.appending(path: biometric)
}
//22cf1f79-ee53-4aa6-9962-da8103e3c592
enum EndpointsChats {
    static let chats: String = "3eb0304d-b3ce-4619-8c8f-fe786be3a2fe" //"chats" //Response
    static let chatsView: String = "db0065d0-ee83-4514-b2a4-b30ea1723071" //"chats/view" //ChatList
    static let createChat: String = "3e6a389d-a3d6-481d-a0fd-2f2772e60b03" // "chats" //creteChat

    static let urlChats: URL = Base.baseURL.appending(path: chatsView)
    static let urlDeleteChat: URL =  Base.baseURL.appending(path: chats)
    static let urlCreateChat: URL = Base.baseURL.appending(path: createChat)
}

enum EndpointsMessages {
    static let view: String = "e8e28d23-31ba-4328-98ae-b9b7faf7753f" //"messages/view" //messages
    static let chat: String = "9e80d0ca-a901-48bf-a6b2-3d88aaf6fcdb"//"messages/list/" //getChats
    static let newMessage: String = "3eb0304d-b3ce-4619-8c8f-fe786be3a2fe" //"messages/new" //response
    
    static let urlView = Base.baseURL.appending(path: view)
    static let urlChat = Base.baseURL.appending(path: chat)
    static let urlNewMessage = Base.baseURL.appending(path: newMessage)
}
