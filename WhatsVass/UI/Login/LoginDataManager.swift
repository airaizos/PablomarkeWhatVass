//
//  LoginDataManager.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import Foundation

protocol LoginDataManagerProtocol {
    func login(with credentials: [String: Any])  async throws -> LoginResponse
    func loginWithBiometric(params: [String: Any]) async throws -> LoginResponse
}

final class LoginDataManager: LoginDataManagerProtocol {
    private var apiClient: LoginAPIClient

    init(apiClient: LoginAPIClient) {
        self.apiClient = apiClient
    }
    
    //MARK: Async await
    func login(with credentials: [String: Any])  async throws -> LoginResponse {
        try await apiClient.loginByAPI(with: credentials)
    }
    func loginWithBiometric(params: [String: Any]) async throws -> LoginResponse {
        try await  apiClient.biometricLogin(params: params)
    }
    
}
