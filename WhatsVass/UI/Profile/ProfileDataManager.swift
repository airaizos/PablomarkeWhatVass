//
//  ProfileDataManager.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation

protocol ProfileDataManagerProtocol {
    func createAndRegisterProfile(params: [String: Any]) async throws -> UserResponse
}

final class ProfileDataManager: ProfileDataManagerProtocol {
    // MARK: - Properties
    private var apiClient: ProfileAPIClient

    // MARK: - Object lifecycle
    init(apiClient: ProfileAPIClient = ProfileAPIClient()) {
        self.apiClient = apiClient
    }

    func createAndRegisterProfile(params: [String: Any]) async throws -> UserResponse {
        try await apiClient.createAndRegisterProfileInAPI(params: params)
    }
    
}
