//
//  LoginDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 13/5/24.
//

import Foundation

final class LoginDataManagerMock: LoginDataManagerProtocol {
    func login(with credentials: [String : Any]) async throws -> LoginResponse {
        try Bundle.decode(type: LoginResponse.self, from: "loginResponse")
    }
    
    func loginWithBiometric(params: [String : Any]) async throws -> LoginResponse {
        try Bundle.decode(type: LoginResponse.self, from: "loginResponse")
    }
}
