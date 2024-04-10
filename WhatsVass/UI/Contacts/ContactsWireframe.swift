//
//  ContactsWireframe.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import Combine
import UIKit
import SwiftUI

final class ContactsWireframe {

    private var newChatSubject: PassthroughSubject<Chat, Never>
    private var cancellables: Set<AnyCancellable> = .init()

    init(newChatSubject: PassthroughSubject<Chat, Never>) {
        self.newChatSubject = newChatSubject
    }

    // MARK: - Properties
    var viewController: UIViewController {
        let dataManager = createDataManager(apiClient: apiClient)
        let viewModel = createViewModel(with: dataManager)
        let viewController = ContactsViewController(viewModel: viewModel)
        return viewController
    }

    private var apiClient: ContactsAPIClient {
        return ContactsAPIClient()
    }

    // MARK: - Private methods
    private func createViewModel(with dataManager: ContactsDataManager) -> ContactsViewModel {
        let viewModel = ContactsViewModel(dataManager: dataManager)
        viewModel.chatSubject
            .sink(receiveValue: { [weak self] chat in
                self?.newChatSubject.send(chat)
            })
            .store(in: &cancellables)
        return viewModel
    }

    private func createDataManager(apiClient: ContactsAPIClient) -> ContactsDataManager {
        let dataManager = ContactsDataManager(apiClient: apiClient)
        return dataManager
    }

    // MARK: - Navigation
    func present(navigation: UINavigationController?) {
        navigation?.present(viewController, animated: true)
    }
}
