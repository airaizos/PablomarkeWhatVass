//
//  HomeViewController.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 13/3/24.
//

import Combine
import SwiftUI

final class HomeViewController: UIHostingController<HomeView> {
    private let viewModel: HomeViewModel
    private let contactsWireframe: ContactsWireframe
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.contactsWireframe = ContactsWireframe(newChatSubject: viewModel.navigateToChatSubject)
            super.init(rootView: HomeView(viewModel: viewModel))

        self.viewModel.navigateToChatSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] chat in
                self?.navigateToChat(chat)
            }
            .store(in: &cancellables)

        self.viewModel.newChatSelectedSubject
            .sink { [weak self] _ in
                self?.navigateToNewChat()
            }
            .store(in: &cancellables)

        self.viewModel.navigateToProfileSubject
            .sink { [weak self] _ in
                self?.navigateToProfileScreen()
            }
            .store(in: &cancellables)

        self.viewModel.navigateToSettingsSubject
            .sink { [weak self] _ in
                self?.navigateToSettings()
            }
            .store(in: &cancellables)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true,
                                                     animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false,
                                                     animated: animated)
    }
}

// MARK: - Navigation
extension HomeViewController {
    func navigateToProfileScreen() {
        ProfileWireframe().push(navigation: navigationController)
    }

    func navigateToChat(_ chat: Chat) {
        ChatWireframe(chat: chat).push(navigation: navigationController)
    }

    func navigateToNewChat() {
        contactsWireframe.present(navigation: navigationController)
    }

    func navigateToSettings() {
        SettingsWireframe().push(navigation: navigationController)
    }
}
