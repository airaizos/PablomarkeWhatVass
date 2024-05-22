//
//  SettingsAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import Foundation

final class SettingsAPIClient: BaseAPIClient {
    func logout() async throws -> LogOutResponse {
        try await fetchCodable(url: EndpointsUsers.urlLogout, type: LogOutResponse.self)
    }
}
