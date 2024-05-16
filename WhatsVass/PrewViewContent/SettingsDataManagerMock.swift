//
//  SettingsDataManagerMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import Foundation
import Combine


final class SettingsDataManagerMock: SettingsDataManagerProtocol {
    func logout() async throws -> LogOutResponse {
       try Bundle.decode(type: LogOutResponse.self, from: "logoutResponse")
    }
    
    func logOut() -> AnyPublisher<LogOutResponse, BaseError> {
        Bundle.loadJsonPublisher(type: LogOutResponse.self, from: "logoutResponse")
    }
}
