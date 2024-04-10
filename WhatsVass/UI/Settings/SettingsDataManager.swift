//
//  SettingsDataManager.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import Foundation
import Combine

final class SettingsDataManager {
    // MARK: - Properties
    private var apiClient: SettingsAPIClient

    // MARK: - Object lifecycle
    init(apiClient: SettingsAPIClient) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods
    func logOut() -> AnyPublisher <LogOutResponse, BaseError> {
        apiClient.logout()
            .tryMap { response in
                return response
            }
            .mapError { error in
                return error as? BaseError ?? .generic
            }
            .eraseToAnyPublisher()
    }
}
