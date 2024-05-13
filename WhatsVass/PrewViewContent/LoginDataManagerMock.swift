//
//  LoginDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 13/5/24.
//

import Foundation
import Combine

final class LoginDataManagerMock: LoginDataManagerProtocol {
    func login(with credentials: [String : Any]) -> AnyPublisher<LoginResponse, BaseError> {
        Bundle.loadJsonPublisher(type: LoginResponse.self, from: "loginResponse")
    }
    
    func loginWithBiometric(params: [String : Any]) -> AnyPublisher<LoginResponse, BaseError> {
        Bundle.loadJsonPublisher(type: LoginResponse.self, from: "loginResponse")
    }
}
