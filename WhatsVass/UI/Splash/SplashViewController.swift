//
//  SplashViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import SwiftUI

final class SplashViewController: UIHostingController<SplashView> {

    // MARK: - Properties
    private var viewModel: SplashViewModel?

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(rootView: SplashView(viewModel: viewModel))
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: .splash, object: nil, queue: .main) { [weak self] _ in
            self?.navigateToLogin()
        }
    }
    
    func navigateToLogin() {
        LoginWireframe().push(navigation: self.navigationController)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .splash, object: nil)
    }
}
