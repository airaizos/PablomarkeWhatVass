//
//  ProfileAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation

final class ProfileAPIClient: BaseAPIClient {
    //TODO: Manar todos los datos del profile
    func createAndRegisterProfileInAPI(params: [String: Any]) async throws -> UserResponse {
        guard let profile = prepareProfile(with: params) else {
            throw  BaseError.noCodable
         }
        return  try await postCodable(url: EndpointsUsers.urlRegister, data: profile)
    }
    
    private func prepareProfile(with params: [String: Any]) -> Profile? {
        guard let email = params["email"] as? String,
                let password = params["password"] as? String,
                let nickname = params["nickname"] as? String,
                let avatar = params["avatar"] as? String,
                let platform = params["platform"] as? String,
                let token = params["token"] as? String else {
            return nil
        }
        return Profile(email: email, password: password, nickname: nickname, avatar: avatar, token: token, platform: platform)
       
    }
}
