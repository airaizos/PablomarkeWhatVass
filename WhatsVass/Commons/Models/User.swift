//
//  User.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation

struct User: Codable, Hashable {
    let id, nick, avatar: String
    let online: Bool
}

struct UserResponse: Codable {
    let success: Bool
    let user: UserResponseInfo
}

struct UserResponseInfo: Codable {
    let id, login, password, nick, platform, avatar, uuid, token: String
    let online: Bool
}

struct LogOutResponse: Codable {
    let message: String
}

struct Profile: Codable, Hashable {
    let email: String //username
    let password: String //Hash
    let nickname: String
    let avatar: String
    let token: String
    let platform: String
}
