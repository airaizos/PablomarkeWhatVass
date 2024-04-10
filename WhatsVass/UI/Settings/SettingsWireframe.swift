//
//  SettingsWireframe.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import UIKit

final class SettingsWireframe {
    // MARK: - Properties
    var viewController: SettingsViewController {
        // Generating module components
        let secureDataProvider: KeyChainDataProvider = KeyChainDataProvider()
        let viewController: SettingsViewController = SettingsViewController()
        let dataManager: SettingsDataManager = createDataManager(apiClient: apiClient)
        let viewModel: SettingsViewModel = createViewModel(with: dataManager,
                                                           secureDataProvider: secureDataProvider)
        viewController.set(viewModel: viewModel)
        return viewController
    }

    private var apiClient: SettingsAPIClient {
        return SettingsAPIClient()
    }

    // MARK: - Private methods
    private func createViewModel(with dataManager: SettingsDataManager,
                                 secureDataProvider: KeyChainDataProvider) -> SettingsViewModel {
        return SettingsViewModel(dataManager: dataManager,
                                 secure: secureDataProvider)
    }

    private func createDataManager(apiClient: SettingsAPIClient) -> SettingsDataManager {
        let dataManager = SettingsDataManager(apiClient: apiClient)
        return dataManager
    }

    // MARK: - Public methods
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }

        navigation.pushViewController(viewController,
                                      animated: true)
    }
}
