//
//  LoginDataManager.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import Foundation
import Combine

final class LoginDataManager {
    // MARK: - Properties
    private var apiClient: LoginAPIClient

    // MARK: - Object lifecycle
    init(apiClient: LoginAPIClient) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods
    func login(with credentials: [String: Any]) -> AnyPublisher <LoginResponse, BaseError> {
        apiClient.loginByAPI(with: credentials)
            .tryMap { loginResponse in
               //saveCodableToDocumentsDirectory(loginResponse, fileName: "loginResponse.json")
                return loginResponse
            }
            .mapError { error in
                return error as? BaseError ?? .failedLogin
            }
            .eraseToAnyPublisher()
    }

    func loginWithBiometric(params: [String: Any]) -> AnyPublisher <LoginResponse, BaseError> {
        apiClient.biometricLogin(params: params)
            .tryMap { loginResponse in
                 //saveCodableToDocumentsDirectory(loginResponse, fileName: "loginWithBiometrics.json")
                return loginResponse
            }
            .mapError { error in
                return error as? BaseError ?? .noBiometrics
            }
            .eraseToAnyPublisher()
    }
}
