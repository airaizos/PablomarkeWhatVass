//
//  SplashWireframe.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import UIKit

final class SplashWireframe {
    // MARK: - Properties
    var viewController: SplashViewController {
        // Generating module components
        let viewController: SplashViewController = SplashViewController()
        let viewModel: SplashViewModel = createViewModel()
        viewController.set(viewModel: viewModel)
        return viewController
    }

    // MARK: - Private methods
    private func createViewModel() -> SplashViewModel {
        return SplashViewModel()
    }
}
