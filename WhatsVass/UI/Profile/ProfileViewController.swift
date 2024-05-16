//
//  ProfileViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import SwiftUI
import Combine

protocol ProfileViewDelegate {
    func createProfile(user: String, nick: String, password: String, confirmPassword: String)
}

final class ProfileViewController:UIHostingController<ProfileView> {

    // MARK: - Properties
    private var viewModel: ProfileViewModel?
    
    var cancellables: Set<AnyCancellable> = []

   
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(rootView: ProfileView(viewModel: viewModel))
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: .navigateToHomeView, object: nil, queue: .main) { [weak self] _ in
            self?.navigateToHome()
        }
    }

    // MARK: - Public methods
    func set(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .navigateToHomeView, object: nil)
    }
}

// MARK: - Private extension for metohds -
private extension ProfileViewController {
    
    func navigateToHome() {
            HomeWireframe().push(navigation: navigationController)
    }
}
