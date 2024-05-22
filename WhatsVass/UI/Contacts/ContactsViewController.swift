//
//  ContactsViewController.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import SwiftUI
/*
final class ContactsViewController: UIHostingController<ContactsView> {
    var viewModel: ContactsViewModel

    private var cancellable = Set<AnyCancellable>()

    init(viewModel: ContactsViewModel) {
        self.viewModel = viewModel
        super.init(rootView: ContactsView(viewModel: viewModel))

        viewModel.chatSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .store(in: &cancellable)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
