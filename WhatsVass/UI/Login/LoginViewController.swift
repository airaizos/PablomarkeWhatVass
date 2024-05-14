//
//  LoginViewController.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 6/3/24.
//

import SwiftUI
import Combine
import IQKeyboardManagerSwift

final class LoginViewController: BaseViewController, LoginViewDelegate {

    // MARK: - Properties
    var viewModel: LoginViewModel?
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        let loginView = LoginView(delegate: self)
        let hostingController = UIHostingController(rootView: loginView)
        setHostingControllerView(view, hostingController: hostingController)
    }

    // MARK: - Public methods
    func set(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
}

extension LoginViewController {
    func initView() {
        viewModel?.initData()
        responseViewModel()
    }
    
    func loginTapped(remember: Bool) {
        viewModel?.loginButtonWasTapped(remember: remember)
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
//        DispatchQueue.main.async {
//            self.tfUser.text = ""
//            self.tfPassword.text = ""
//            self.tfUser.setNeedsDisplay()
//            self.tfPassword.setNeedsDisplay()
//        }
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
    
    //MARK: Delegate
    func loginUser(_ user: String) {
        viewModel?.username = user
    }
    
    func loginPassword(_ pass: String) {
        viewModel?.password = pass
    }
    
    func rememberUserAndPassword(_ remember:Bool) {
        viewModel?.rememberLoginPreferences(remember)
    }
}

protocol LoginViewDelegate {
    func initView()
    func rememberEnterWithBiometrics()
    func loginTapped(remember: Bool)
    func navigateToProfileView()
    func rememberUserAndPassword(_ remember:Bool)
    func loginUser(_ user: String)
    func loginPassword(_ pass: String)
}
