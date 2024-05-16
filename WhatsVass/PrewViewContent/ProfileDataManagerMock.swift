//
//  ProfileDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 16/5/24.
//

import Foundation


final class ProfileDataManagerMock: ProfileDataManagerProtocol {
    func createAndRegisterProfile(params: [String : Any]) async throws -> UserResponse {
        try Bundle.decode(type: UserResponse.self, from: "createAndRegisterProfile")
    }
}
