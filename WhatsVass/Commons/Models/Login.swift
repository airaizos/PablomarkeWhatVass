//
//  Login.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation

struct Login: Codable {
    let password, username, platform, token: String
}

//TODO: En el server
struct LoginResponse: Codable {
    let success: Bool
    let id: String
    let nickname: String
    let avatar: String
}
