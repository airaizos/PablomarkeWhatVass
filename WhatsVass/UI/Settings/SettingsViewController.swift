//
//  SettingsViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import SwiftUI
/*
final class SettingsViewController: UIHostingController<SettingsView> {
    
    private var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(rootView: SettingsView(viewModel: viewModel))
        
        NotificationCenter.default.addObserver(forName: .logout, object: nil, queue: .main) { [weak self] _ in
            self?.navigateToLoginIfDisconnect()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func navigateToLoginIfDisconnect() {
        LoginWireframe().push(navigation: navigationController)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .logout, object: nil)
    }
}
*/
