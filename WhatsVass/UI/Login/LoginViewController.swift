//
//  LoginViewController.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 6/3/24.
//

import SwiftUI

final class LoginViewController: UIHostingController<LoginView> {

    // MARK: - Properties
    var viewModel: LoginViewModel

    let persistence: LocalPersistence = .shared
        
    init(viewModel: LoginViewModel)  {
        self.viewModel = viewModel
        super.init(rootView: LoginView(viewModel: viewModel))
        
        NotificationCenter.default.addObserver(forName: .signIn, object: nil, queue: .main) { [weak self] _ in
            self?.navigateToProfileView()
        }
        
        NotificationCenter.default.addObserver(forName: .login, object: nil, queue: .main) { [weak self] _ in
            self?.navigateToHomeView()
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .signIn, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .login, object: nil)
    }
}

extension LoginViewController {

    func navigateToHomeView() {
        HomeWireframe().push(navigation: navigationController)
    }

    func navigateToProfileView() {
        ProfileWireframe().push(navigation: navigationController)
    }
}

