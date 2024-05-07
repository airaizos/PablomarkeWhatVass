//
//  ProfileAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation
import Combine
import Alamofire

final class ProfileAPIClient: BaseAPIClient {
    func createAndRegisterProfileInAPI(params: [String: Any]) -> AnyPublisher <UserResponse, BaseError> {
       guard let data = encodeRegister(with: params) else {
            return Fail(error: BaseError.noCodable).eraseToAnyPublisher()
        }
        return requestPostPublisher(url: EndpointsUsers.urlRegister, data: data)
    }
    
    private func encodeRegister(with params: [String: Any]) -> Data? {
        guard let login = params["login"] as? String, let password = params["password"] as? String, let nick = params["nick"] as? String, let platform = params["platform"] as? String, let token = params["firebaseToken"] as? String else {
            return nil
        }
        let newLogin = Login(password: password, login: login, platform: platform, nick: nick, firebaseToken: token)
        guard let data = try? JSONEncoder().encode(newLogin) else { return nil }
        return data
    }
    
}
