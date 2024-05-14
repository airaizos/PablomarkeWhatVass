//
//  LoginAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import Foundation
import Combine

final class LoginAPIClient: BaseAPIClient {
    func loginByAPI(with credentials: [String: Any]) -> AnyPublisher <LoginResponse, BaseError> {
        guard let data = encodeRegister(with: credentials) else {
            return Fail(error: BaseError.failedLogin).eraseToAnyPublisher()
        }
       return requestPostPublisher(url: EndpointsUsers.urlLogin, data: data)
    }

    func biometricLogin(params: [String: Any]) -> AnyPublisher <LoginResponse, BaseError> {
        guard let data = encodeToken(with: params) else {
            return Fail(error: BaseError.failedLogin).eraseToAnyPublisher()
        }
       return requestPostPublisher(url: EndpointsUsers.urlBiometric, data: data)
    }
    
    private func encodeRegister(with params: [String: Any]) -> Data? {
        guard let login = params["login"] as? String, let password = params["password"] as? String, let platform = params["platform"] as? String, let token = params["firebaseToken"] as? String else {
            return nil
        }
        let newLogin = Login(password: password, login: login, platform: platform, nick: "nick", firebaseToken: token)
        guard let data = try? JSONEncoder().encode(newLogin) else { return nil }
        return data
    }
    
    private func encodeToken(with params: [String: Any]) -> Data? {
        guard let auth = params["Authorization"] as? String else {
            return nil
        }
        guard let data = try? JSONEncoder().encode(auth) else { return nil }
        return data
        
    }
}
