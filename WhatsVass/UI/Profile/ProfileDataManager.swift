//
//  ProfileDataManager.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation
import Combine

final class ProfileDataManager {
    // MARK: - Properties
    private var apiClient: ProfileAPIClient

    // MARK: - Object lifecycle
    init(apiClient: ProfileAPIClient) {
        self.apiClient = apiClient
    }
    // MARK: - Public Methods
    func createAndRegisterProfile(params: [String: Any]) -> AnyPublisher<UserResponse, BaseError> {
        apiClient.createAndRegisterProfileInAPI(params: params)
            .tryMap { loginResponse in
                //saveCodableToDocumentsDirectory(loginResponse, fileName: "createAndRegisterProfile.json")
                return loginResponse
            }
            .mapError { error in
                return error as? BaseError ?? .generic
            }
            .eraseToAnyPublisher()
    }
    func createAndRegisterProfile(params: [String: Any]) async throws {
        
    }
    
}
