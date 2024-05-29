//
//  Login.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation

struct Login: Codable {
    let password, login, platform, nick, firebaseToken: String
}

//TODO: En el server
struct LoginResponse: Codable {
    let token: String
    let user: User
}
