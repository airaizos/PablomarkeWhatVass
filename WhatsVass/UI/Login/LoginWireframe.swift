//
//  LoginWireframe.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import UIKit

final class LoginWireframe {
    // MARK: - Properties
    var viewController: LoginViewController {
        // Generating module components
        let secureDataProvider: KeyChainData = KeyChainData()
        let viewController: LoginViewController = LoginViewController()
        let dataManager: LoginDataManager = createDataManager(apiClient: apiClient)
        let viewModel: LoginViewModel = createViewModel(with: dataManager,
                                                        secureDataProvider: secureDataProvider)
        viewController.set(viewModel: viewModel)
        return viewController
    }

    private var apiClient: LoginAPIClient {
        return LoginAPIClient()
    }

    // MARK: - Private methods
    private func createViewModel(with dataManager: LoginDataManager,
                                 secureDataProvider: KeyChainData) -> LoginViewModel {
        return LoginViewModel(dataManager: dataManager,
                              secure: secureDataProvider)
    }

    private func createDataManager(apiClient: LoginAPIClient) -> LoginDataManager {
        let dataManager = LoginDataManager(apiClient: apiClient)
        return dataManager
    }

    // MARK: - Public methods
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }

        navigation.pushViewController(viewController,
                                      animated: true)
    }
}
