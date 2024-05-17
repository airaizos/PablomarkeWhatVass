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
        let viewModel: SplashViewModel = createViewModel()
        let viewController: SplashViewController = SplashViewController(viewModel: viewModel)
        return viewController
    }

    private func createViewModel() -> SplashViewModel {
        return SplashViewModel()
    }
}
