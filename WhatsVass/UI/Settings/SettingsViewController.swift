//
//  SettingsViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import UIKit
import Combine

final class SettingsViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var svSettings: UIStackView!
    @IBOutlet weak var btSettings: UIButton!
    @IBOutlet weak var lbNotifications: UILabel!
    @IBOutlet weak var swNotificacions: UISwitch!
    @IBOutlet weak var lbThemes: UILabel!
    @IBOutlet weak var swThemes: UISwitch!
    @IBOutlet weak var lbBiometrics: UILabel!
    @IBOutlet weak var swBiometrics: UISwitch!
    @IBOutlet weak var lbIdioms: UILabel!

    // MARK: - Properties
    private var viewModel: SettingsViewModel?
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        prepareAndConfigView(titleForView: "Settings")
        configView()
        responseViewModel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Public methods
    func set(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Buttons
    @IBAction func btaSettings(_ sender: Any) {
        viewModel?.logOut()
    }

    @IBAction func swaNotificaciones(_ sender: Any) {
        viewModel?.notificationIsOn(bool: swNotificacions.isOn)
    }
    @IBAction func swaThemes(_ sender: Any) {
        viewModel?.themesIsOn(bool: swThemes.isOn)
    }

    @IBAction func swaBiometric(_ sender: Any) {
        viewModel?.biometricsIsOn(bool: swBiometrics.isOn)
    }
}

// MARK: - Private extension for metohds -
private extension SettingsViewController {
    func configView() {
        configButton()
        configLabels()
        configSwitch()
    }

    func configButton() {
        btSettings.chatVassStyle("Logout")
    }

    func configLabels() {
        lbIdioms.chatVassStyle(text: "")
        lbThemes.chatVassStyle(text: "Themes")
        lbBiometrics.chatVassStyle(text: "Biometrics")
        lbNotifications.chatVassStyle(text: "Notifications")
    }

    func configSwitch() {
        swThemes.chatVassStyle(isOn: viewModel?.themes ?? false)
        swBiometrics.chatVassStyle(isOn: viewModel?.biometrics ?? false)
        swNotificacions.chatVassStyle(isOn: viewModel?.notifications ?? false)
    }

    func responseViewModel() {
        viewModel?.logOutSuccessSubject.sink(receiveValue: { _ in
            self.navigateToLoginIfDisconnect()
        }).store(in: &cancellables)
    }

    // MARK: - Navigation
    func navigateToLoginIfDisconnect() {
        LoginWireframe().push(navigation: navigationController)
    }
}
