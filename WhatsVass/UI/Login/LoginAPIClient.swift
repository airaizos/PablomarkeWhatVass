//
//  LoginAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import Foundation

final class LoginAPIClient: BaseAPIClient {

    //MARK: - Async Await -
    func loginByAPI(with credentials: [String: Any]) async throws -> LoginResponse {
      //  let data = try encodeRegister(with: credentials)
        let login = try constructLoginWith(credentials)
        return try await postCodable(url: EndpointsUsers.urlLogin, data: login)
    }
    
    func biometricLogin(params: [String: Any]) async throws -> LoginResponse {
        let data = try encodeToken(with: params)
        return try await postCodable(url: EndpointsUsers.urlBiometric, data: data)
    }
    
    
    //MARK: private Methods
    func constructLoginWith(_ params:[String: Any]) throws -> Login {
        guard let login = params["login"] as? String, let password = params["password"] as? String, let platform = params["platform"] as? String, let token = params["firebaseToken"] as? String else {
            throw BaseError.failedLogin
        }
        return Login(password: password, login: login, platform: platform, nick: "nick", firebaseToken: token)
    }
    
    private func encodeRegister(with params: [String: Any]) throws -> Data {
        let newLogin = try constructLoginWith(params)
        guard let data = try? JSONEncoder().encode(newLogin) else {
            throw BaseError.noCodable
        }
        return data
    }
    
    private func encodeToken(with params: [String: Any]) throws -> Data {
        guard let auth = params["Authorization"] as? String else {
           throw BaseError.failedLogin
        }
        guard let data = try? JSONEncoder().encode(auth) else {
            throw BaseError.noCodable
        }
        return data
    }
}
