//
//  LoginViewController.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 6/3/24.
//

import UIKit
import Combine
import IQKeyboardManagerSwift

final class LoginViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var btProfile: UIButton!
    @IBOutlet weak var lbRemember: UILabel!
    @IBOutlet weak var swRemember: UISwitch!

    // MARK: - Properties
    var viewModel: LoginViewModel?
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
    }

    // MARK: - Public methods
    func set(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Actions
    @IBAction func btLoginDidTap(_ sender: Any) {
        viewModel?.loginButtonWasTapped(remember: swRemember.isOn)
    }

    @IBAction func btaCreateUser(_ sender: Any) {
        navigateToProfileView()
    }
}

// MARK: - Private extension for setup and response methods
private extension LoginViewController {
    func initView() {
        viewModel?.initData()
        responseViewModel()
        configRememberStack()
    }

    func configView() {
        prepareAndConfigView(titleForView: "",
                             navBarHidden: true)
        configTextFields()
        configButtons()

    }

    func configTextFields() {
        tfUser.chatVassStyle("User")
        tfPassword.chatVassStyle("Password",
                                 secure: true)
        tfUser.delegate = self
        tfPassword.delegate = self
    }

    func responseViewModel() {
        viewModel?.loginSuccessSubject
            .sink { [weak self] remember in
                remember ? self?.rememberEnterWithBiometrics() : self?.navigateToHomeView()
            }.store(in: &cancellables)

        viewModel?.loginSuccessBiometrics
            .sink(receiveValue: { [weak self] _ in
                self?.navigateToHomeView()
            }).store(in: &cancellables)

        viewModel?.loginFailureSubject
            .sink { [weak self] _ in
                self?.showAlertSimple(title: "Login error",
                                      message: "Incorrect username or password")
            }.store(in: &cancellables)
        viewModel?.loginFailureBiometrics
            .sink(receiveValue: { _ in
                self.reset()
            }).store(in: &cancellables)
    }

    func reset() {
        DispatchQueue.main.async {
            self.tfUser.text = ""
            self.tfPassword.text = ""
            self.tfUser.setNeedsDisplay()
            self.tfPassword.setNeedsDisplay()
        }
    }

    func configButtons() {
        btLogin.chatVassStyle("Login")
        btProfile.setTitle(NSLocalizedString("Sign in",
                                             comment: ""),
                           for: .normal)
    }

    func configRememberStack() {
        lbRemember.chatVassStyle(text: "Remember",
                                 size: 12)
        lbRemember.textColor = AssetsColors.customWhite
        swRemember.chatVassStyle(large: false)
        if let remember = viewModel?.rememberLogin {
            swRemember.isOn = remember
            rememberUserAndPassword()
        }
    }

    func rememberUserAndPassword() {
        tfUser.text = viewModel?.username
        tfPassword.text = viewModel?.password
    }

    func navigateToHomeView() {
        HomeWireframe().push(navigation: navigationController)
    }

    func navigateToProfileView() {
        ProfileWireframe().push(navigation: navigationController)
    }

    func rememberEnterWithBiometrics() {
        showSelectAlert(title: "Biometrics",
                        message: "EnterBiometrics",
                        yesAction: {
            UserDefaults.standard.setValue(true,
                                           forKey: Preferences.biometrics)
            self.navigateToHomeView()
        }, cancelAction: {
            UserDefaults.standard.setValue(false,
                                           forKey: Preferences.biometrics)
            self.navigateToHomeView()
        })
    }
}

extension LoginViewController {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let newText = (textField.text as NSString?)?.replacingCharacters(in: range,
                                                                               with: string) else {
            return true
        }

        switch textField {
        case tfUser:
            viewModel?.username = newText
        case tfPassword:
            viewModel?.password = newText
        default:
            break
        }

        return true
    }
}
