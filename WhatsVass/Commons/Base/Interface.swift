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
    static let baseURL = URL(string: "https://run.mocky.io/v3/")!

    struct Users {
        static let users = baseURL.appending(component: "4b8542ec-e387-44ed-a542-97895293264a")
        static let login = users.appending(component: "52022ddf-d858-42cd-b87c-0f4db569f156")
        static let logout = users.appending(component: "0e2b6d17-e83c-4535-8657-949816c60e54")
        static let online = users.appending(component: "0e2b6d17-e83c-4535-8657-949816c60e54")
        static let register = users.appending(component:"68a151ee-ac5b-4a8d-a69f-168d4f64cfb1")
        static let biometric = users.appending(component: "62e2639a-576b-4a5b-963a-53d35674bf67")
    }
    
    struct Chats {
        static let chats = baseURL.appending(component: "588cfe52-981a-4b57-9109-e6e6e4c34647")
        static let chatsView = baseURL.appending(component: "9bf79488-8e7d-4bb7-bbc0-49506c4d392d")
        static let createChat = baseURL.appending(component: "6823c6a1-214c-4e70-8123-eb828b430207")
    }
    
    struct Messages {
       // private static let messages = baseURL.appending(component: "messages")
        static let view = baseURL.appending(component: "54bdf6fa-3189-494f-9eae-010f2aa3c823")
        static let chat = baseURL.appending(component: "9fc6d3ae-2274-4d06-a593-5386672ba2d2")
        static let newMessaage = baseURL.appending(component: "68ef2594-e025-4082-a15f-6aa3aa6c0778")
    }
}


enum HTTPMetodos: String {
    case get = "GET"
    case post = "POST"
}
