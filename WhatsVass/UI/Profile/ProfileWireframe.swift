//
//  ProfileWireframe.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import UIKit

final class ProfileWireframe {
    // MARK: - Properties
    var viewController: ProfileViewController {
        // Generating module components
        let viewController = ProfileViewController()
        let dataManager = createDataManager(apiClient: apiClient)
        let viewModel = createViewModel(with: dataManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }

    private var apiClient: ProfileAPIClient {
        return ProfileAPIClient()
    }

    // MARK: - Private methods
    private func createViewModel(with dataManager: ProfileDataManager) -> ProfileViewModel {
        return ProfileViewModel(dataManager: dataManager)
    }

    private func createDataManager(apiClient: ProfileAPIClient) -> ProfileDataManager {
        let dataManager = ProfileDataManager(apiClient: apiClient)
        return dataManager
    }

    // MARK: - Public methods
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }

        navigation.pushViewController(viewController, animated: true)
    }
}
