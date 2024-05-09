//
//  SettingsViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import SwiftUI
import Combine

final class SettingsViewController: BaseViewController, SettingsDelegate {

    // MARK: - Properties
    private var viewModel: SettingsViewModel?
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        prepareAndConfigView(titleForView: "Settings")
        responseViewModel()
        
        let settingsView = SettingsView(delegate: self)
        let hostingController = UIHostingController(rootView:settingsView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Public methods
    func set(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Delegate
    func logoutButton() {
        viewModel?.logOut()
    }
    
    func isBiometricsActive(_ isOn: Bool) {
        viewModel?.biometricsIsOn(isOn)
    }
    
    func isNotificationsActive(_ isOn: Bool) {
        viewModel?.notificationIsOn(isOn)
    }
    
    func isDarkThemeActive(_ isOn: Bool) {
        viewModel?.themesIsOn(isOn)
    }
    
}

// MARK: - Private extension for metohds -
private extension SettingsViewController {
    func responseViewModel() {
        viewModel?.logOutSuccessSubject.sink(receiveValue: { _ in
            self.navigateToLoginIfDisconnect()
        })
        .store(in: &cancellables)
    }
    
    // MARK: - Navigation
    func navigateToLoginIfDisconnect() {
        LoginWireframe().push(navigation: navigationController)
    }
}
