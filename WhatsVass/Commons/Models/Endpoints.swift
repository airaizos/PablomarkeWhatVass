//
//  Endpoints.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation

enum Base {
    static let chats = Base.local.appending(path: "chats")
    static let login = Base.local.appending(path: "loging")
    
    //MARK: -OLD-
    //   static let mockMovilidad: String = "https://mock-movilidad.vass.es/chatvass/api/"
    //  static let mock: String = "https://run.mocky.io/v3/"
    static let baseURL: URL = URL(string: "https://run.mocky.io/v3/")!
    static let local: URL = URL(string: "http://127.0.0.1:8081/whats")!
}
enum EndpointsUsers {
    static let urlLogin = Base.login.appending(path: "login")
    static let urlUsers = Base.login.appending(path: "users")
    static let urlRegister = Base.login.appending(path: "profile")
    
    //MARK: -OLD-
   // static let login: String =   "login"                 //"f380a68e-676f-4c8f-8d7a-479b9db32ee2" //"users/login //loginResponse"
    static let logOut: String = "3c35da26-67f5-468e-9df5-841491b7312a" //"users/logout" //logoutResponse
    static let online: String = "0e2b6d17-e83c-4535-8657-949816c60e54" //"users/online/"
    static let register: String = "26877e6c-68c4-4b1c-a051-46bbddea8f6d"//"users/register" //createAndRegisterProfile
    static let biometric: String = "f380a68e-676f-4c8f-8d7a-479b9db32ee2" //"users/biometric" //
 //   static let users: String = "4f81b431-e058-438d-ad56-da33b70828fe" //"users" //getContacts
    
    
   
    static let urlLogout = Base.baseURL.appending(path: logOut)
    static let urlBiometric = Base.baseURL.appending(path: biometric)
}
//22cf1f79-ee53-4aa6-9962-da8103e3c592
enum EndpointsChats {
    static let urlChats: URL = Base.chats.appending(path: "list")
    
    //MARK: -OLD-
    static let chats: String = "3eb0304d-b3ce-4619-8c8f-fe786be3a2fe" //"chats" //Response
  //  static let chatList: String = "list" //"7c7606dc-591a-4a2b-8314-646a9b2e1e33" //"chats/view" //ChatList
    static let createChat: String = "3e6a389d-a3d6-481d-a0fd-2f2772e60b03" // "chats" //creteChat

    static let urlDeleteChat: URL =  Base.baseURL.appending(path: chats)
    static let urlCreateChat: URL = Base.baseURL.appending(path: createChat)
}

enum EndpointsMessages {
    static let urlMessages = Base.chats.appending(path: "messages")
    static let urlChat = Base.chats.appending(path: "chatMessages")
    
    //  static let messages: String = "messages" //"e8e28d23-31ba-4328-98ae-b9b7faf7753f" //"messages/view" //messages
    // static let chatMessages: String = "chatMessages" //"b043e2cc-71d5-4f2f-b817-586d56143175"//"messages/list/" //getChats
    static let newMessage: String = "3eb0304d-b3ce-4619-8c8f-fe786be3a2fe" //"messages/new" //response
    static let urlNewMessage = Base.baseURL.appending(path: newMessage)
}
