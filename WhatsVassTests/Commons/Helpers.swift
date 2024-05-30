//
//  Helpers.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest

@testable import WhatsVass

let credentials = ["password": "password",
                   "login": "username",
                   "platform": "ios",
                   "firebaseToken": "fgjñdjsfgdfj"]

let profileCredentials = ["password": "passwordValue",
                          "email": "usernameValue",
                          "nickname": "nicknameValue",
                          "avatar": "avatarValue",
                          "platform": "ios",
                          "token": "token Value"]

let params = ["Authorization": "token"]

let sendMessageParams = ["chat": "test chat",
                         "source": "source",
                         "message": "Test message"]
