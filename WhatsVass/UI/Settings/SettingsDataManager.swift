//
//  SettingsDataManager.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import Foundation

protocol SettingsDataManagerProtocol {
    @discardableResult
    func logout() async throws -> LogOutResponse
}

final class SettingsDataManager: SettingsDataManagerProtocol {
    // MARK: - Properties
    private var apiClient: SettingsAPIClient

    // MARK: - Object lifecycle
    init(apiClient: SettingsAPIClient = SettingsAPIClient()) {
        self.apiClient = apiClient
    }

    @discardableResult
    func logout() async throws -> LogOutResponse {
        try await apiClient.logout()
    }
}
